### Issue

`test_script.rb` and `test_script_with_params.rb` both show a single allocation.

`test_script_with_untyped_params.rb` and `test_script_with_untyped_return.rb` both show 1,000,000 allocations coming from [`sorbet-runtime-0.4.5135/lib/types/private/methods/call_validation.rbL126`](https://github.com/sorbet/sorbet/blob/b4d2c1a0f78a6694ecdc75d3e83431e1ad50c474/gems/sorbet-runtime/lib/types/private/methods/call_validation.rb#L126)

### Steps

* `gem install bundler`
* `bundle install`
* Run each of the ruby scripts with `bundle exec ruby <script>`
* View the outputted metrics with `open <results>.html`
