class CanvasPage
    constructor: (@pg_dimensions, @pg_num) ->
        @canv = null
    setCanvasElement: (elem) ->
        # console.log $(elem)
        parent = $(elem).parent()
        parent_w = parent.width()
        parent_h = parent.height()
        @canv = new fabric.Canvas(elem)
        @canv.setWidth parent_w
        @canv.setHeight parent_h
        @setPageBackground()
        undefined
    addDraggedElement: (elem, coords) ->
        switch elem
            when 'bodytext'
                console.log 'added bodytext :: ' + coords.x + ', ' + coords.y
                @addTextElement(coords)
            when 'image'
                console.log 'added image :: ' + coords.x + ', ' + coords.y
                @addImageElement(coords)
            when 'shape'
                console.log 'added shape :: ' + coords.x + ', ' + coords.y
                @addShapeElement(coords)
            when 'line'
                console.log 'added line :: ' + coords.x + ', ' + coords.y
                @addLineElement(coords)
            when 'heading'
                console.log 'added heading :: ' + coords.x + ', ' + coords.y
                @addHeadingElement(coords)
            when 'subheading'
                console.log 'added subheading :: ' + coords.x + ', ' + coords.y
                @addSubheadingElement(coords)
        # @canv.add txt
        undefined
    setPageNumber: (num) ->
        @pg_num = num
        undefined
    addTextElement: (coords) ->
        newTextElement = new fabric.IText 'bob',
            left: coords.x
            top: coords.y
            originX: 'center'
            originY: 'center'
        @canv.add newTextElement
        undefined
    addImageElement: (coords) ->
        url = 'https://www.google.com/images/srpr/logo11w.png'
        opts =
            left: coords.x
            top: coords.y
            originX: 'center'
            originY: 'center'
        newImageElement = new fabric.Image.fromURL url, (oImg) =>
            @canv.add oImg
        , opts
        undefined
    addShapeElement: (coords) ->
        newShapeElement = new fabric.Circle(
                left: coords.x
                top: coords.y
                radius: 100
                fill: '#f33'
                originX: 'center'
                originY: 'center'
            )
        @canv.add newShapeElement
        undefined
    addLineElement: (coords) ->
        newLineElement = new fabric.Text(
                p: v
            )
        undefined
    addHeadingElement: (coords) ->
        newHeadingElement = new fabric.Text(
                p: v
            )
        undefined
    addSubheadingElement: (coords) ->
        newSubheadingElement = new fabric.Text(
                p: v
            )
        undefined
    setPageBackground: ->
        pageRect = new fabric.Rect(
                backgroundColor: 'yellow'
                fill: 'pink'
                borderColor: 'blue'
            )
        @canv.add pageRect
        undefined
