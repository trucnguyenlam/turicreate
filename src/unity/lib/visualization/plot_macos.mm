/* Copyright © 2019 Apple Inc. All rights reserved.
 *
 * Use of this source code is governed by a BSD-3-clause license that can
 * be found in the LICENSE.txt file or at https://opensource.org/licenses/BSD-3-Clause
 */

#include "plot.hpp"
#import <vega_renderer/VegaRenderer.h>
#import <Foundation/Foundation.h>

namespace turi {
  namespace visualization {
    bool Plot::render(CGContextRef context, tc_plot_variation variation) {
      std::string spec_with_data = this->get_spec(variation, true /* include_data */);
      Plot::render(spec_with_data, context);
      return this->finished_streaming();
    }

    void Plot::render(const std::string& vega_spec, CGContextRef context) {
      NSString *spec = [NSString stringWithUTF8String:vega_spec.c_str()];
      VegaRenderer *renderer = [[VegaRenderer alloc] initWithSpec:spec];
      CGContextDrawLayerAtPoint(context, CGPointMake(0, 0), renderer.CGLayer);
    }
  }
}