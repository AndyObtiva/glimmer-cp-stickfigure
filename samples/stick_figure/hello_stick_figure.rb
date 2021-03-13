# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
        
