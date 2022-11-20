# brotli_and_cheese

A **currently failing** experiment in implementing Brotli compression in the
[permessage-deflate](https://tools.ietf.org/html/draft-ietf-hybi-permessage-compression)
WebSocket protocol extension as an extension for Action Cable.

It is hacked together from a fork of @jcoglan's [permessage-deflate-ruby](https://github.com/faye/permessage-deflate-ruby), with inspiration from the `brotli` and `rack-brotli` gems.

I want to stress that I'm not confident that this is a problem that can be solved. My understanding of "deflate" as a concept is fuzzy; what I have intuited is that there is an extension interface to which a module can identify itself as a provide of `permessage-deflate` hooks. My premise is that "deflate" alludes to the way the binary output of a compression function is converted to a string that can be broadcast via WS thanks to the LS77 algorithm.

I further assumed that if the client suggests (via `HTTP_ACCEPT_ENCODING`) that it supports "gzip, deflate, br", so long as we have a good reference implementation, we should be able to swap out gzip for Brotli.

I have done the bare minimum amount I could manage to get this working, and so far, it has not been successful. I would _love_ to get any assistance possible, starting with a "that should work" or a "what the hell were you even thinking".

Step 1: validate if this can even work.

If we can get this working, I'd love to take a page from `rack-brotli` and fall back gracefully; first to gzip, then to plaintext.

## Installation

Add the following to your `Gemfile`:

```ruby
gem "brotli_and_cheese", github: "leastbad/brotli_and_cheese", branch: "main"
```

If you check it out locally, you can tell Bundler to look for your local copy:

```bash
bundle config local.brotli_and_cheese /home/leastbad/brotli_and_cheese
```

## Usage

Add the extension to your `config/initializers/action_cable.rb`:

```rb
module ActionCable
  module Connection
    class ClientSocket
      alias old_initialize initialize
      def initialize(env, event_target, event_loop, protocols)
        # puts env['HTTP_ACCEPT_ENCODING'].include?('br')
        old_initialize(env, event_target, event_loop, protocols)
        @driver.add_extension(BrotliAndCheese.configure)
      end
    end
  end
end
```

Right now, I have the Brotli deflate quality option hard-coded to 5.
