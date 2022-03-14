---
layout: post
title: LSP issues with opencv-python
date: 2022-01-08 00:45 +0530
tags: python short
---

I use the neovim plugin `nvim-lspconfig` and for python, it requires minimal setup and works fine most of the time. One issue that I repeatedly face when working on python projects involving image manipulation is the lack of code-completion and missing type stub errors for the `cv2` (opencv-python) package. The working solution is to manually generate type stubs for the package.

### steps
1. Install the `mypy` package, it has the `stubgen` command that will generate the type stubs.
2. Find `cv2` package directory and store in an environment variable (for now)
```bash
export CV2_DIR=$(python -c 'import cv2, os; print(os.path.dirname(cv2.__file__))')
```
3. Generate stub files in the package directory
```bash
stubgen -m cv2 -o $CV2_DIR
```
4. The previous command generates the stub file and names it `<package_name>.pyi` (`cv2.pyi` in this case) but it has to be renamed to `__init__.pyi` in order to be read by the LSP.
```bash
mv $CV2_DIR/cv2.pyi $CV2_DIR/__init__.pyi
```
5. \[Optional\] unset the `CV2_DIR` environment variable.
```bash
unset CV2_DIR
```

Code completion should work now.

