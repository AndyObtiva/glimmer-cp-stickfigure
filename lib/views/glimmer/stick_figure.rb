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

module Glimmer
  # Creates a class-based custom shape representing the `stick_figure` keyword by convention
  # When width=height, you get the standard aspect ratio
  # You can pass size instead of width and height to work only with the standard aspect ratio.
  class StickFigure
    include Glimmer::UI::CustomShape
    
    options :location_x, :location_y, :size_width, :size_height, :size
    
    before_body {
      self.location_x ||= 0
      self.location_y ||= 0
      self.size_width ||= size
      self.size_height ||= size
      @head_width = size_width*0.2
      @head_height = size_height*0.2
      @trunk_height = size_height*0.4
      @extremity_length = size_height*0.4
    }
    
    body {
      shape {
        x bind(self, :location_x) { |x_value| x_value.is_a?(Numeric) ? x_value + @head_width/2.0 + @extremity_length : x_value }
        y bind(self, :location_y)
        # width/height are `:default`, thus autocalculated from content.
        
        oval(0, 0, @head_width, @head_height)
        line(@head_width/2.0, @head_height, @head_width/2.0, @head_height + @trunk_height)
        line(@head_width/2.0, @head_height + @trunk_height, @head_width/2.0 + @extremity_length, @head_height + @trunk_height + @extremity_length)
        line(@head_width/2.0, @head_height + @trunk_height, @head_width/2.0 - @extremity_length, @head_height + @trunk_height + @extremity_length)
        line(@head_width/2.0, @head_height*2, @head_width/2.0 + @extremity_length, @head_height + @trunk_height - @extremity_length)
        line(@head_width/2.0, @head_height*2, @head_width/2.0 - @extremity_length, @head_height + @trunk_height - @extremity_length)
      }
    }
  end
end
