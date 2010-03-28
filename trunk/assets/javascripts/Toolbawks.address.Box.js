/*
# Copyright (c) 2007 Nathaniel Brown
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
*/

Toolbawks.address.Box = function() {
  return {
    init : function() {
      Toolbawks.log('Toolbawks.address.Box.init');
/*
      // Scan for countries
      Ext.query('.countries').each(function(country_select) {
        var converted = new Ext.form.ComboBox({
            typeAhead: true,
            triggerAction: 'all',
            transform: country_select.id,
            width: 175,
            forceSelection: true
        });
      });

      // Scan for states
      Ext.query('.states').each(function(state_select) {
        var converted = new Ext.form.ComboBox({
            typeAhead: true,
            triggerAction: 'all',
            transform: state_select.id,
            width: 125,
            forceSelection: true
        });
      });
*/
      // Link countries and states together
    },
    
    set_default_country : function(element, country) {
      element = $(element);
      if (element.options[element.selectedIndex].value != country) {
        for (var x = 0; x < element.options.length; x++) {
          if (element.options[x].value == 'United States') {
            element.selectedIndex = x;
            return true;
          }
        }
      }
      return false;
    }
  };
}();

Ext.onReady(Toolbawks.address.Box.init, Toolbawks.address.Box, true);