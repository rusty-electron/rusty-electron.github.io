require 'commonmarker'
require 'cgi'

sample = <<~'MD'
Inline $\Delta W_{m}=\Delta W_{s}$ and `code $x$` and \$5.

$$
\begin{bmatrix} a & b \\ c & d \end{bmatrix}
$$

- item $v_i^\top x$
MD
html = Commonmarker.to_html(sample, options: { extension: { math_dollars: true } })
raise 'Inline math parsing failed' unless html.include?('data-math-style="inline">\\Delta W_{m}=\\Delta W_{s}')
raise 'Display matrix parsing failed' unless html.include?('data-math-style="display"') && html.include?('\\begin{bmatrix}')
raise 'Code or dollar escaping failed' unless html.include?('<code>code $x$</code>') && html.include?('data-escaped-char')
raise 'List math parsing failed' unless html.include?('data-math-style="inline">v_i^\\top x')

latest = File.read('_site/blog/np-lora-null-space-projection.html', encoding: 'UTF-8')
previous = File.read('_site/blog/algo-running-time-and-power-law.html', encoding: 'UTF-8')
home = File.read('_site/index.html', encoding: 'UTF-8')
raise 'Published post math missing' unless latest.include?('data-math-style="display"') && latest.include?('\\Delta \\mathbf{W}_{m}')
raise 'Equation references missing' unless previous.include?('\\ref{first}') && previous.include?('\\tag{1}')
raise 'Figure captions were escaped' unless previous.scan('<p class="caption">').length == 2 && !previous.include?('&lt;p class=&quot;caption&quot;&gt;')
raise 'Python syntax highlighting missing' unless previous.match?(/<pre[^>]*lang="python"[^>]*><code>\s*<span/)
raise 'Kramdown homepage formatting broken' if home.include?('{: class=')
raise 'MathJax adapter missing' unless latest.include?("document.querySelectorAll('[data-math-style]')")
puts 'Math parsing and site compatibility checks passed.'
