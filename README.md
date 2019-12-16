### Issue

`test_script.rb` and `test_script_with_params.rb` both show a single allocation.

`test_script_with_untyped_params.rb` and `test_script_with_untyped_return.rb` both show 1,000,000 allocations coming from [`sorbet-runtime-0.4.5135/lib/types/private/methods/call_validation.rbL126`](https://github.com/sorbet/sorbet/blob/b4d2c1a0f78a6694ecdc75d3e83431e1ad50c474/gems/sorbet-runtime/lib/types/private/methods/call_validation.rb#L126)

### Steps

* `gem install bundler`
* `bundle install`
* Run each of the ruby scripts with `bundle exec ruby <script>`
* View the outputted metrics with `open <results>.html`

### Results

```
% be ruby test_benchmarks.rb
Rehearsal ------------------------------------------------------------------------------
test                                         0.606854   0.002831   0.609685 (  0.613560)
test_with_params                             0.626262   0.001215   0.627477 (  0.629991)
test_with_untyped_params                     1.118433   0.002735   1.121168 (  1.126615)
test_with_untyped_return                     1.118856   0.001905   1.120761 (  1.126203)
test_with_hash                               1.628735   0.002591   1.631326 (  1.636940)
test_with_untyped_hash                       1.613503   0.002493   1.615996 (  1.625057)
test_with_any                                1.448110   0.002147   1.450257 (  1.453614)
test_with_any_hash                           2.067156   0.003409   2.070565 (  2.079521)
test_with_untyped_and_any_hash               2.653400   0.003448   2.656848 (  2.664769)
test_with_untyped_and_any_hash_void          2.512177   0.004312   2.516489 (  2.535811)
test_with_untyped_and_sealed_hash_void       2.181961   0.004041   2.186002 (  2.204950)
test_with_untyped_and_any_sealed_hash_void   2.540867   0.004329   2.545196 (  2.563824)
-------------------------------------------------------------------- total: 20.151770sec

                                                 user     system      total        real
test                                         0.607425   0.001892   0.609317 (  0.612384)
test_with_params                             0.632841   0.002602   0.635443 (  0.639166)
test_with_untyped_params                     1.137531   0.003301   1.140832 (  1.146658)
test_with_untyped_return                     1.119147   0.001398   1.120545 (  1.123098)
test_with_hash                               1.630998   0.003215   1.634213 (  1.640523)
test_with_untyped_hash                       1.598566   0.003785   1.602351 (  1.609828)
test_with_any                                1.457894   0.003554   1.461448 (  1.469299)
test_with_any_hash                           2.049204   0.002617   2.051821 (  2.059755)
test_with_untyped_and_any_hash               2.671629   0.004916   2.676545 (  2.684429)
test_with_untyped_and_any_hash_void          2.519209   0.004235   2.523444 (  2.533144)
test_with_untyped_and_sealed_hash_void       2.185109   0.005611   2.190720 (  2.218439)
test_with_untyped_and_any_sealed_hash_void   2.545201   0.004699   2.549900 (  2.558650)

% be ruby test_collections.rb
Rehearsal ------------------------------------------------------
test array 1         0.001633   0.000007   0.001640 (  0.001640)
test array 10        0.002205   0.000005   0.002210 (  0.002216)
test array 100       0.009241   0.000011   0.009252 (  0.009260)
test array 1000      0.073443   0.000271   0.073714 (  0.075085)
test array 10000     0.674760   0.002412   0.677172 (  0.682013)
test array 100000    6.562453   0.009387   6.571840 (  6.592870)
test array 1000000  65.381625   0.057674  65.439299 ( 65.605760)
test hash 1          0.003540   0.001038   0.004578 (  0.005961)
test hash 10         0.003685   0.000079   0.003764 (  0.003932)
test hash 100        0.022476   0.000191   0.022667 (  0.022996)
test hash 1000       0.151338   0.000477   0.151815 (  0.152664)
test hash 10000      1.462264   0.004186   1.466450 (  1.489089)
test hash 100000    14.525712   0.015364  14.541076 ( 14.588925)
test hash 1000000  144.319462   0.148477 144.467939 (144.955132)
------------------------------------------- total: 233.433416sec

                         user     system      total        real
test array 1         0.001402   0.000009   0.001411 (  0.001412)
test array 10        0.002171   0.000018   0.002189 (  0.002216)
test array 100       0.011831   0.000146   0.011977 (  0.012937)
test array 1000      0.080788   0.000572   0.081360 (  0.085975)
test array 10000     0.664641   0.002452   0.667093 (  0.671095)
test array 100000    6.579924   0.008369   6.588293 (  6.605127)
test array 1000000  65.513594   0.056795  65.570389 ( 65.759214)
test hash 1          0.001540   0.000002   0.001542 (  0.001537)
test hash 10         0.003228   0.000001   0.003229 (  0.003225)
test hash 100        0.025696   0.000315   0.026011 (  0.029627)
test hash 1000       0.153644   0.000433   0.154077 (  0.156136)
test hash 10000      1.517537   0.003968   1.521505 (  1.530889)
test hash 100000    14.884682   0.018167  14.902849 ( 14.988549)
test hash 1000000  148.223978   0.180804 148.404782 (149.243664)
```
