@app.directive "ngBug", ["$timeout", ($timeout) ->
  template: "<svg width=\"100\" height=\"100\" xmlns=\"http://www.w3.org/2000/svg\">
     <g>
       <title>Layer 1</title>
         <g id=\"svg_11\">
            <path id=\"svg_3\" class=\"body\" d=\"m118,355.42685c0,-10.47031 22.87646,-18.95123 51.11903,-18.95123c28.24252,0 51.11902,8.48093 51.11902,18.95123c0,10.47025 -22.8765,18.95117 -51.11902,18.95117c-28.24257,0 -51.11903,-8.48093 -51.11903,-18.95117z\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"#19d619\"/>
               <ellipse ry=\"12.54878\" rx=\"13.18333\" id=\"svg_4\" class=\"body\" cy=\"339.54878\" cx=\"217.81662\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"#19d619\"/>
                    <line id=\"svg_6\" y2=\"389.7439\" x2=\"125.53333\" y1=\"370.28049\" x1=\"135.75714\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"none\"/>
                       <line id=\"svg_7\" y2=\"390\" x2=\"171.54045\" y1=\"375.65854\" x1=\"171.8095\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"none\"/>
                          <line id=\"svg_8\" y2=\"387.43902\" x2=\"217.00948\" y1=\"371.04878\" x1=\"201.94282\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"none\"/>
                             <ellipse ry=\"1.53659\" rx=\"1.61429\" id=\"svg_9\" cy=\"336.47561\" cx=\"222.92853\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"#000000\"/>
                                <ellipse id=\"svg_10\" ry=\"1.53659\" rx=\"1.61429\" cy=\"335.96341\" cx=\"213.24282\" stroke-linecap=\"null\" stroke-linejoin=\"null\" stroke-width=\"5\" stroke=\"#000000\" fill=\"#000000\"/>
                                  </g>
                                   </g>
                                   </svg>"

  #link: (scope, element, attrs) ->
    #debugger
  compile: (scope, element, attrs) ->
    pre: (scope, element, attrs) ->
      element.find('.body').attr('fill', attrs.color)
    post: (scope, element, attrs) ->

]
