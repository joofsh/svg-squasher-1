@app.directive "ngBug", ["$timeout", ($timeout) ->
  template: "<svg width=\"100\" height=\"100\" xmlns=\"http://www.w3.org/2000/svg\">
            <ellipse class=\"wings\" ry=\"25\" rx=\"15\" cx=\"55\" cy=\"15\" style=\"fill:white;stroke:black;stoke-width:2\"/>
            <ellipse class=\"wings\" ry=\"25\" rx=\"15\" cx=\"65\" cy=\"15\" style=\"fill:white;stroke:black;stoke-width:2\"/>
            <ellipse class=\"body\" ry=\"20\" rx=\"45\" cx=\"55\" cy=\"35\" style=\"stroke:black;stoke-width:2\"/>
               <ellipse ry=\"12.54878\" rx=\"13.18333\" class=\"body head\" cy=\"18.54878\" cx=\"101.81662\" style=\"stroke:black;stoke-width:4\" />

                           <ellipse class=\"eye\" ry=\"1.53659\" rx=\"1.61429\" id=\"svg_9\" cy=\"15.47561\" cx=\"106.92853\"  style=\"fill:black;stroke:black;stroke-width:1\" />
                              <ellipse class=\"eye\" ry=\"1.53659\" rx=\"1.61429\" cy=\"14.96341\" cx=\"97.24282\" style=\"fill:black;stroke:black;stroke-width:1\" />
                                 </svg>"


  compile: (scope, element, attrs) ->
    pre: (scope, element, attrs) ->
      element.find('.body').attr('fill', attrs.color)

      for ele in element.children().children()
        properties = ['rx','ry','cx','cy']
        for prop in properties
          $(ele).attr(prop, $(ele).attr(prop)*attrs.ratio) if ele.hasOwnProperty(prop)


    post: (scope, element, attrs) ->

]
