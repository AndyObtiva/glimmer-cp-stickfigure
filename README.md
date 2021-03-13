# Stick Figure 0.1.0
## [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 /> Glimmer Custom Shape](https://github.com/AndyObtiva/glimmer-dsl-swt/docs/reference/GLIMMER_COMMAND.md#custom-shape-gem)
[![Gem Version](https://badge.fury.io/rb/glimmer-cp-stickfigure.svg)](http://badge.fury.io/rb/glimmer-cp-stickfigure)

[Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) Stick Figure Custom Shape.

`stick_figure` is the [Glimmer GUI DSL](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_GUI_DSL_SYNTAX.md#glimmer-gui-dsl-syntax) keyword provided by this [gem](https://rubygems.org/gems/glimmer-cp-stickfigure).

### Screenshot

![stickfigure screenshot](/images/glimmer-cp-stickfigure-hello-stick-figure.png)

### Actual Use

It is used in [DCR](https://github.com/AndyObtiva/dcr) (Draw Color Repeat).

![DCR](https://raw.githubusercontent.com/AndyObtiva/dcr/master/images/dcr-screenshot.png)

## Setup

### Bundler

Add the follwing to `Gemfile`:
```ruby
gem 'glimmer-cp-stickfigure', '~> 0.1.0'
```

Run `bundle install` or `bundle`:
```
bundle
```

### Direct

Run:
```
gem install glimmer-cp-stickfigure
```

## API

First, add this to your [Ruby](https://www.ruby-lang.org/en/) file:
```ruby
require 'glimmer-cp-stickfigure'
```

Then, use this keyword:
```ruby
stick_figure(options) { properties }
```

Options (keyword args) are:
- `:location_x` (default: 0) (optional): starting location x coordinate within parent
- `:location_y` (default: 0) (optional): starting location y coordinate within parent
- `:size` (required unless width/height are specified): size in pixels for width and height (resulting in bevel squares having that size)
- `:size_width` (required unless size is specified): size in pixels for width and height (resulting in bevel squares having that size)
- `:size_height` (required unless size is specified): size in pixels for width and height (resulting in bevel squares having that size)

Properties:
- `foreground` (default: `:black`): specifies stick figure color.

## Sample

The [glimmer-cp-stickfigure Ruby gem](https://rubygems.org/gems/glimmer-cp-stickfigure) adds to glimmer samples, showing up when you run:
```
glimmer samples
```

### Hello, Stick Figure!

[Glimmer GUI DSL](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_GUI_DSL_SYNTAX.md#glimmer-gui-dsl-syntax) code (from [samples/stick_figure/hello_stick_figure.rb](/samples/stick_figure/hello_stick_figure.rb)):

```ruby
require_relative '../../lib/glimmer-cp-stickfigure'

class HelloStickFigure
  include Glimmer::UI::CustomShell
  
  WIDTH = 220
  HEIGHT = 235
  
  body {
    shell {
      text 'Hello, Stick Figure!'
      minimum_size WIDTH, HEIGHT
    
      @canvas = canvas {
        background :white
        
        15.times { |n|
          x_location = (rand*WIDTH/2).to_i%WIDTH + (rand*15).to_i
          y_location = (rand*HEIGHT/2).to_i%HEIGHT + (rand*15).to_i
          foreground_color = rgb(rand*255, rand*255, rand*255)
          
          stick_figure(location_x: x_location, location_y: y_location, size: 35+n*2) {
            foreground foreground_color
          }
        }
        
        on_mouse_down { |mouse_event|
          @drag_detected = false
          @canvas.cursor = :hand
          # select shape at location
          @selected_shape = @canvas.shape_at_location(mouse_event.x, mouse_event.y)
          # select shape parent if it is a nested shape like an arm or leg
          @selected_shape = @selected_shape.parent_shapes.last if @selected_shape.parent_shapes.any?
        }
        
        on_drag_detected { |drag_detect_event|
          @drag_detected = true
          @drag_current_x = drag_detect_event.x
          @drag_current_y = drag_detect_event.y
        }
        
        on_mouse_move { |mouse_event|
          if @drag_detected
            @selected_shape&.move_by(mouse_event.x - @drag_current_x, mouse_event.y - @drag_current_y)
            @drag_current_x = mouse_event.x
            @drag_current_y = mouse_event.y
          end
        }
        
        on_mouse_up { |mouse_event|
          @canvas.cursor = :arrow
          @drag_detected = false
          @selected_shape = nil
        }
      }
    }
  }
end

HelloStickFigure.launch
```

Hello, Stick Figure!

![Hello Stick Figure](/images/glimmer-cp-stickfigure-hello-stick-figure.png)

## Contributing to glimmer-cp-bevel

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## TODO

[TODO.md](/TODO.md)

## Change Log

[CHANGELOG.md](/CHANGELOG.md)

## License

[MIT](LICENSE.txt)

Copyright (c) 2021 - Andy Maleh.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) (JRuby Desktop Development GUI Framework).
