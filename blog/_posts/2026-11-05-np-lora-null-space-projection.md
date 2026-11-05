---
layout: post
title:  "NP-LoRA: Null Space Projection for Subject-Style LoRA Fusion"
date:   2026-11-04 20:00:00 +0100
tags: ml lora wip
katex: true
---

> **Status: work in progress.** These are my reading notes on the paper, written while working through the math. Expect gaps and rough edges.

- Title: *NP-LoRA: Null Space Projection for Subject-Style LoRA Fusion*
- Source: [arxiv.org/pdf/2511.11051](https://arxiv.org/pdf/2511.11051)

We write a LoRA matrix, \({}\Delta \mathbf{W}{}\) as:
$$
\Delta \mathbf{W}=\mathbf{BA}
$$
where \({}\mathbf{A}{}\) is the up-projection matrix and \({}\mathbf{B}{}\) is the down-projection matrix.

The LoRA matrix can be SVD decomposed as:
$$\Delta \mathbf{W} = \mathbf{U\Sigma V^\top}$$
> The vectors in \(\mathbf{V}\) identify at most \(r\) input directions that the update can detect.

- \(\mathbf{V}\) contains the normalized eigen vectors of \(\Delta \mathbf{W} \Delta \mathbf{W}^\top\)
- \(\mathbf{U}\) contains the normalized eigen vectors of \(\Delta \mathbf{W}^\top\Delta \mathbf{W}\)

\(\Delta W \in ℝ^{(m × n)}\), rank \((\Delta W) = r\)

$$U \in \mathbb{R}^{m \times r}, \Sigma \in \mathbb{R}^{r \times r}, V \in \mathbb{R}^{n \times r},$$ \(\Sigma\) has \(r\) singular values.

rank(\(U\)) = rank(\(V\)) = rank(\(\Sigma\)) = r

\(V^T x\)
- column vectors of \(V^T\) are orthogonal. $$V^Tx = \mathbf{v_1}^T x_1 + \mathbf{v_2}^T x_2 + \dots$$
- Alternatively, $$ V^Tx = \begin{bmatrix} v_1^Tx \\ v_2^Tx \\ \vdots \end{bmatrix}$$
  - Here each value \(v_i^Tx\) asks the question how much does \(x\) point along the input direction \(v_i\). If \(v_i \perp x\) then the \(i\)-th value will be zero.
  - Say that x is orthogonal to the column space of V: $$V^Tx=0$$Then, for that adapted linear map,$$\Delta W x = UΣ V x = 0.$$So LoRA adds no change to that layer output for that particular input vector.
  - SVD can also be thought of as a sum of rank-1 matrices formed by the outer product of the left and right singular vectors, weighted by the respective singular values. $$\Delta Wx = \sum^{r}_{i=1} \sigma_i u_i(v_i^\top x)$$ If \(x\) has no component along any \(v_i\), then \(v_i^{\top}x=0\).

The vectors in \(U\) identify at most \(r\) output directions that the update can produce.

> This means that once we have calculated the signed lengths of the projections of \(x\) along the right singular vectors \(v_i\), we multiply \(V^Tx\) with \(U\) which contains the left singular vectors. They are the normalized eigen basis of \(AA^T\).

- If \(\alpha_i = \mathbf{v}^{\top}_i x\) then we can write the update as: $$\Delta W x = \sum^r_{i=1} \sigma_i \alpha_i u_i$$ For each \(i\),
  - \(\alpha_i\) measures the signed amount of \(x\) along the input direction \(v_i\).
  - \(\sigma_i\) scales this and
  - \(u_i\) is the output direction for that contribution.
- The pair \((\mathbf{v_i}, \mathbf{u_i})\) states: input variation along \(\mathbf{v_i}\) produces output variation along \(\mathbf{u}_i\).
- Overall, if the input vector \(x\) has a component along the column vectors in \(V\) then the LoRA update \(\Delta W\) will affect the directions \(\mathbf{u_i}\) in \(U\).

**Rank-one LoRA example**

For a rank-one update:

$$\Delta W = \sigma_1 u_1v_1^\top$$

Let:

$$v_1 = \left[1, 0\right]^\top, \qquad u_1 = \left[0, 1\right]^\top, \qquad \sigma_1 = 3$$

For input:

$$x = \left[2, 5\right]^\top$$

The component of \(x\) along \(v_1\) is:

$$v_1^\top x = 2$$

The LoRA update output is:

$$\Delta W x = 3 \cdot 2 \cdot \left[0, 1\right]^\top = \left[0, 6\right]^\top$$

Thus, the update adds \(6\) to the second coordinate of the base layer output. It adds nothing to the first coordinate.

If:

$$W_0x = \left[10, -1\right]^\top$$

then the adapted output is:

$$(W_0 + \Delta W)x = \left[10, -1\right]^\top + \left[0, 6\right]^\top = \left[10, 5\right]^\top$$

The vector \(v_1\) detects the first input coordinate. The vector \(u_1\) specifies the output direction that LoRA changes.

- What is the function of the content LoRA?
  - Given input \(x\) to a given layer with weight \(W_0\) where we apply \(\Delta W = U\Sigma V^T\), the \(V\) matrix will detect directions in the input vector \(x\) that align with its column vectors. \(V^\top x\) gives us the signed lengths of \(x\) along the column vectors directions of \(V\). These signed lengths are scaled by the respective singular values in \(\Sigma\). The resulting weights \(\sigma_i v_i^\top x\) is then used to update the directions of the column vectors in \(U\).
    - Consider the example of teaching an image generation model to generate images of dogs in Van Gogh style of painting. The model knows how to generate images of dogs and also the van gogh style of painting. This task can then be completed with just a suitable prompt. What is the use case of LoRA then?
      - The prompt tells the model what you want. The content LoRA supplies learned visual information that the base model may not know or may not preserve consistently (maintain identity across the various generated images), e.g., a rare bird that was not in the training set of the image generation model.
    - Consider a image generation model that can only generate images of dogs. If I LoRA-train it to generate images of cats then what happens?
      - Will the model learn to generate images of cats?
        - Possibly. The base model may have visual features useful for the generation of cat images (edges, fur texture, eye, tails, poses, etc.) The LoRA can then redirect them towards cat images.
        - It may lack internal representations for cat-specific features. More training data or larger LoRA rank may be needed.
      - Cats and dogs share semantic features like overall structure, body fur, number of legs, tail, heads, etc., they mainly differ in terms of head shape and body shape. Is the task of teaching the same model to generate images of cars more difficult?
        - Yes, for the same LoRA rank and training setup as before.
        - Teaching to generate cars may require larger changes across more layers.

**Questions**
- Does LoRA work on CNNs?
- How does fine-tuning compare to LoRA?

## Content LoRA and style LoRA

content LoRA: dog
- detects directions in the hidden states like edges, animal face, texture, etc., and updates the weights towards outputting dog-like features (triangles, dog face, fur texture).

style LoRA: van gogh style
- detects directions in the hidden states like edges, texture, background, etc., and updates the weights towards outputting van gogh-like features (curves, grainy texture, blue and yellow shapes).

Both LoRAs can respond to similar hidden-state directions, such as texture or shape information. Their output changes can then conflict when direct merging adds both updates.
$$\mathbf{P = V_k V_k} ^\top,$$ where \(\mathbf{P} \in \mathbb{R}^{m \times m}\) and \(\mathbf{V_k} \in \mathbb{R}^{m \times k}\) is formed by selecting \(k\) vectors from the right singular matrix \(\mathbf{V}\) that have non-zero singular values in. \(\mathbf{P}\) takes an \(m\)-dimensional vector \(\mathbf{x}\) and finds \(k\)-coordinates which are projections along the singular directions in \({}\mathbf{V}_{k}{}\), while doing so it reduces \(\mathbf{x}\) to \(k\)-dimensions. \({}\mathbf{V}_{k}{}\) then brings it back to \(m\)-dimensional space and expresses the \(k\)-coordinates in terms of the standard basis. \({}\mathbf{V}_{k}\mathbf{V}_{k}^\top\mathbf{x}{}\) is a vector in the \(k\)-dimensional subspace in \({}\mathbb{R}^n{}\).

**What does \(\mathbf{P}\) do?**

\(\mathbf{P}\) transforms a given vector \(\mathbf{x}\) into another vector in the \(k\)-dimensional subspace in \(\mathbb{R}^n\), keeping only the components along \(\mathbf{V}_{k}\). If \(V_{k}\) correspond to the style directions in the LoRA \(\Delta \mathbf{W}_{S}\) then \(\mathbf{P}\) will keep only these input directions in \(\mathbf{x}\). \(\mathbf{I} - \mathbf{P}\) keeps the other input components.

\(\mathbf{P}\) can also be formed as:
$$
\mathbf{P}=\mathbf{Q}\mathbf{Q}^\top
$$
where \(\mathbf{Q}\) is formed as the QR-decomposition of the transpose of the up-projection matrix, \(\mathbf{A}^\top=\mathbf{QR}\). \(\mathbf{Q}\) and \(\mathbf{V}\) span the same subspace. This works when \(k=r\) but if we choose \(k<r\) then we have to use a method like SVD decomposition.

When both the style and content LoRA are applied:
$$
\Delta \mathbf{W}_{m} = \Delta \mathbf{W}_{s}+\Delta \mathbf{W}_{c}
$$

\({}\Delta \mathbf{W}_{s}{}\) and \({}\Delta \mathbf{W}_{c}{}\) both update singular directions. Some of the directions are common to both the LoRA matrices and this causes a collision. The solution proposed by the authors of NP-LoRA is to "remove" the colliding singular vectors from one of the LoRA matrices and then merge the style and content LoRAs.

The content LoRA can be split into these two parts:
$$
\Delta \mathbf{W}_{c} = \Delta \mathbf{W}_{c}\mathbf{P}+\Delta \mathbf{W}_{c}(\mathbf{I}-\mathbf{P})
$$
The first terms acts on \({}\mathbf{P}\mathbf{x}{}\), the component of \({}\mathbf{x}{}\) in the style subspace. The second terms acts on \({}(\mathbf{I} - \mathbf{P})\mathbf{x}{}\), the component outside that subspace. In case of direct merging, the content LoRA can affect the subspace where the style LoRA acts.
$$
\Delta \mathbf{W}_{m}\mathbf{P} = \Delta \mathbf{W}_{s}+\Delta \mathbf{W}_{c}\mathbf{P}
$$
NP-LoRA use hard projection to avoid this issue:
$$
\Delta \mathbf{W}_{m} = \Delta \mathbf{W}_{s}+\Delta \mathbf{W}_{c}(\mathbf{I}-\mathbf{P})
$$
This way the update directions of content LoRA don't collide with those of the style LoRA.
$$
\Delta \mathbf{W}_{m}\mathbf{P} = \Delta \mathbf{W}_{s}
$$
Instead of hard projection where the directions of the content LoRA along the style LoRA are eliminated, a soft projection approach would be as follow:

Let \({}\mathbf{X}{}\) be the changed content update.

$$
\min_{\mathbf{X}} ||\mathbf{X} - \Delta \mathbf{W}_{c}||_{F}^2 + ||\mathbf{X}\mathbf{P}||_{F}^2
$$
The first term ensures that the content update \({}\mathbf{X}{}\) stays close to the original content update, \({}\Delta \mathbf{W}_{c}{}\) while the second term penalizes the part of \({}\mathbf{X}{}\) that acts on the style subspace.

The closed form solution is \({}\mathbf{X}=\Delta \mathbf{W}_{c}(\mathbf{I} + \mu \mathbf{P})^{-1}{}\). A more intuitive form is:
$$
\mathbf{X} = \Delta \mathbf{W}_{c}(\mathbf{I}-\mathbf{P}) + \frac{1}{1+\mu}\Delta \mathbf{W}_{c}\mathbf{P}.
$$

The content update that doesn't affect the style subspace remains the same while the part along that subspace is attenuated by a factor of \({}\frac{1}{1+\mu}{}\). When \(\mu=0\), direct merging happens while when \(\mu=\infty\), hard projection happens.

## Projection without forming dense matrices

\({}\Delta \mathbf{W}_{m}=\Delta \mathbf{W}_{s} + \Delta \mathbf{W}_{c}(\mathbf{I}-\mathbf{P}){}\)

It can also be written as:

\({}\Delta \mathbf{W}_{m}=\mathbf{B}_{s}\mathbf{A}_{s} + \mathbf{B}_{c}\mathbf{A}_{c}(\mathbf{I-P}){}\)

We focus on the second part:

\({}\mathbf{B}_{c}\mathbf{A}_{c}(\mathbf{I-P}) = \mathbf{B}_{c}\mathbf{A}_{c}(\mathbf{I-QQ^\top})=\mathbf{B}_{c}(\mathbf{\mathbf{A}_{c}-\mathbf{A}_{c}QQ^\top}){}\)

We define \({}\mathbf{A}_{c}^\prime{}\) and introduce the \({}\mu{}\) parameter there:
$$
\mathbf{A}_{c}^\prime = \mathbf{\mathbf{A}_{c}-\frac{\mu}{1+\mu}\mathbf{A}_{c}QQ^\top}
$$

The new equation becomes:
$$
{}\Delta \mathbf{W}_{m}=\mathbf{B}_{s}\mathbf{A}_{s} + \mathbf{B}_{c}\mathbf{A}_{c}^\prime{}
$$
We can express this equation as a larger LoRA factor pair.

$$
\mathbf{B}_{m} = \begin{bmatrix}
\mathbf{B}_{s} & \mathbf{B}_{c}
\end{bmatrix} \\
\\
\mathbf{A}_{m} =
\begin{bmatrix}
\mathbf{A}_{s}  \\
\mathbf{A}^\prime_{c}
\end{bmatrix} \\ \\

\Delta \mathbf{W}_{m} = \mathbf{B}_{m}\mathbf{A}_{m}
$$
The rank of the style LoRA and the content LoRA are at most \(r_s\) and \(r_c\) resp. Therefore, as per the sub-additivity property, the rank of the merged LoRA is at most \(r_s + r_c\).

## Evaluations

The style and content LoRAs are merged using different methods like NP-LoRA, K-LoRA, direct merging, etc. Each of the outputs of the merged LoRA are compared against the content and style images. This comparison is done using visual feature similarity methods like DINO and CLIP. The arithmetic mean and harmonic mean of the four comparisons are reported.

The harmonic mean is emphasized because it is penalized more than arithmetic mean if one of its input values is small.

$$
S_{harmonic} = \frac{n}{\frac{1}{x_{1}} + \frac{1}{x_{2}} + \cdots \frac{1}{x_{n}}}
$$
where \({}n{}\) is the number of values and \({}x_{i}{}\) is the \(i\)-th value.

TODO: qualitative evaluation write-up still pending.
