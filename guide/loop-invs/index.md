[{"bookPath":"guide","title":"Finding and using loop invariants","titleId":"guide-loop-invs","hasOtp":true,"hasPageHeader":true},"<p>\n  <i id=\"p_0\" class=\"pid\"></i>Reach requires that <span class=\"snip\"><a href=\"/rsh/consensus/#rsh_while\" title=\"rsh: while\"><span style=\"color: var(--shiki-token-keyword)\">while</span></a></span> loops are annotated with <a href=\"https://en.wikipedia.org/wiki/Loop_invariant\">loop invariants</a>.\n  A loop invariant is a property <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span> which is true before the loop starts and is true after the loop ends.<a href=\"#p_0\" class=\"pid\">0</a>\n</p>\n<p><i id=\"p_1\" class=\"pid\"></i>Consider the following program fragment,<a href=\"#p_1\" class=\"pid\">1</a></p>\n<pre class=\"snippet numbered\"><div class=\"codeHeader\">&nbsp;<a class=\"far fa-copy copyBtn\" data-clipboard-text=\"... before ...\nvar V = INIT;\ninvariant( INV );\nwhile ( COND ) {\n ... body ...\n V = NEXT;\n continue; }\n... after ...\nassert(P);\" href=\"#\"></a></div><ol class=\"snippet\"><li value=\"1\"><span style=\"color: var(--shiki-token-keyword)\">...</span><span style=\"color: var(--shiki-color-text)\"> before </span><span style=\"color: var(--shiki-token-keyword)\">...</span></li><li value=\"2\"><a href=\"/rsh/consensus/#rsh_var\" title=\"rsh: var\"><span style=\"color: var(--shiki-token-keyword)\">var</span></a><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">V</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-keyword)\">=</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">INIT</span><span style=\"color: var(--shiki-color-text)\">;</span></li><li value=\"3\"><a href=\"/rsh/consensus/#rsh_invariant\" title=\"rsh: invariant\"><span style=\"color: var(--shiki-token-function)\">invariant</span></a><span style=\"color: var(--shiki-color-text)\">( </span><span style=\"color: var(--shiki-token-constant)\">INV</span><span style=\"color: var(--shiki-color-text)\"> );</span></li><li value=\"4\"><a href=\"/rsh/consensus/#rsh_while\" title=\"rsh: while\"><span style=\"color: var(--shiki-token-keyword)\">while</span></a><span style=\"color: var(--shiki-color-text)\"> ( </span><span style=\"color: var(--shiki-token-constant)\">COND</span><span style=\"color: var(--shiki-color-text)\"> ) {</span></li><li value=\"5\"><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-keyword)\">...</span><span style=\"color: var(--shiki-color-text)\"> body </span><span style=\"color: var(--shiki-token-keyword)\">...</span></li><li value=\"6\"><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">V</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-keyword)\">=</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">NEXT</span><span style=\"color: var(--shiki-color-text)\">;</span></li><li value=\"7\"><span style=\"color: var(--shiki-color-text)\"> </span><a href=\"/rsh/consensus/#rsh_continue\" title=\"rsh: continue\"><span style=\"color: var(--shiki-token-keyword)\">continue</span></a><span style=\"color: var(--shiki-color-text)\">; }</span></li><li value=\"8\"><span style=\"color: var(--shiki-token-keyword)\">...</span><span style=\"color: var(--shiki-color-text)\"> after </span><span style=\"color: var(--shiki-token-keyword)\">...</span></li><li value=\"9\"><a href=\"/rsh/compute/#rsh_assert\" title=\"rsh: assert\"><span style=\"color: var(--shiki-token-function)\">assert</span></a><span style=\"color: var(--shiki-color-text)\">(</span><span style=\"color: var(--shiki-token-constant)\">P</span><span style=\"color: var(--shiki-color-text)\">);</span></li></ol></pre>\n<p><i id=\"p_2\" class=\"pid\"></i>We can summarize the properties that must be true about this code as follows:<a href=\"#p_2\" class=\"pid\">2</a></p>\n<ul>\n  <li><i id=\"p_3\" class=\"pid\"></i><span class=\"snip\"><span style=\"color: var(--shiki-color-text)\">before</span></span> and <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">V</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-keyword)\">=</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">INIT</span></span> implies <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span> --- The earlier part of the program must establish <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span>.<a href=\"#p_3\" class=\"pid\">3</a></li>\n  <li><i id=\"p_4\" class=\"pid\"></i>If <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">COND</span></span> and <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span>, then <span class=\"snip\"><span style=\"color: var(--shiki-color-text)\">body</span></span> and <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">V</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-keyword)\">=</span><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">NEXT</span></span> implies <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span> --- The loop body can make use of the truth of the condition and the invariant to re-establish the invariant after <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">V</span></span> is mutated to <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">NEXT</span></span>.<a href=\"#p_4\" class=\"pid\">4</a></li>\n  <li><i id=\"p_5\" class=\"pid\"></i><span class=\"snip\"><a href=\"/rsh/compute/#rsh_!\" title=\"rsh: !\"><span style=\"color: var(--shiki-token-keyword)\">!</span></a><span style=\"color: var(--shiki-color-text)\"> </span><span style=\"color: var(--shiki-token-constant)\">COND</span></span> and <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">INV</span></span> and <span class=\"snip\"><span style=\"color: var(--shiki-color-text)\">after</span></span> implies <span class=\"snip\"><span style=\"color: var(--shiki-token-constant)\">P</span></span> --- The later part of the program can make use of the negation of the condition and the invariant to establish any future assertions.<a href=\"#p_5\" class=\"pid\">5</a></li>\n</ul>\n<p>\n  <i id=\"p_6\" class=\"pid\"></i>Loop invariants only need to mention values that can vary because of the execution of the loop.\n  In Reach, all bindings are immutable, except for those bound by <span class=\"snip\"><a href=\"/rsh/consensus/#rsh_while\" title=\"rsh: while\"><span style=\"color: var(--shiki-token-keyword)\">while</span></a></span>, so they never need to be mentioned.\n  However, Reach has two kinds of mutable bindings: loop variables and the contract balance (which is imperatively modified by <span class=\"snip\"><a href=\"/rsh/step/#rsh_pay\" title=\"rsh: pay\"><span style=\"color: var(--shiki-color-text)\">pay</span></a></span> and <span class=\"snip\"><a href=\"/rsh/consensus/#rsh_transfer\" title=\"rsh: transfer\"><span style=\"color: var(--shiki-color-text)\">transfer</span></a></span>).\n  As such, both of these are typically mentioned in loop invariants.<a href=\"#p_6\" class=\"pid\">6</a>\n</p>\n<p>\n  <i id=\"p_7\" class=\"pid\"></i>Loop variables are mentioned if they occur in subsequent assertions, or if they are used to perform potentially unsafe actions, like an array dereference.\n  But, since every Reach program terminates with the token linearity property, loop invariants always reference the contract balance.<a href=\"#p_7\" class=\"pid\">7</a>\n</p>\n<p>\n  <i id=\"p_8\" class=\"pid\"></i>When designing a loop invariant, first write down an equation for the contract balance before the loop.\n  If the loop contains any transfers to the contract, then you must be able to track the amount and number of these.\n  In the best case, you should be able to express the balance as an equation over the existing loop variables.\n  In the worst case, you will have to add more loop variables to track some quantity, like the number of rounds of a game, that the balance is derived from.<a href=\"#p_8\" class=\"pid\">8</a>\n</p>\n<p><i id=\"p_9\" class=\"pid\"></i>After you've tracked the balance, you will need to add additional clauses that track whatever properties you rely on in the tail of the loop.<a href=\"#p_9\" class=\"pid\">9</a></p>\n<p>\n  <i id=\"p_10\" class=\"pid\"></i>The most complex circumstance is when you have nested loops.\n  In this situation, the inner loop's invariant will have to include clauses related to the outer loop's invariant.<a href=\"#p_10\" class=\"pid\">10</a>\n</p>","<ul><li class=\"dynamic\"><a href=\"#guide-loop-invs\">Finding and using loop invariants</a></li></ul>"]