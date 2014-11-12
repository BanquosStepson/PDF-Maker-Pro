class CanvasPage
    constructor: (@pg_dimensions, @pg_num) ->
        @canv = null
    setCanvasElement: (elem) ->
        console.log $(elem)
        parent = $(elem).parent()
        parent_w = parent.width()
        parent_h = parent.height()
        @canv = new fabric.Canvas(elem)
        @canv.setWidth parent_w
        @canv.setHeight parent_h
        @setPageBackground()
        undefined
    addDraggedElement: (elem) ->
        switch elem
            when 'bodytext'
                console.log 'bodytext'
                @addTextElement()
            when 'image'
                console.log 'image'
                @addImageElement()
            when 'shape'
                console.log 'shape'
                @addShapeElement()
            when 'line'
                console.log 'line'
                @addLineElement()
            when 'heading'
                console.log 'heading'
                @addHeadingElement()
            when 'subheading'
                console.log 'subheading'
                @addSubheadingElement()
        # @canv.add txt
        undefined
    setPageNumber: (num) ->
        @pg_num = num
        undefined
    addTextElement: ->
        newTextElement = new fabric.IText('bob')
        @canv.add newTextElement
        undefined
    addImageElement: ->
        url = 'https://www.google.com/images/srpr/logo11w.png'
        newImageElement = new fabric.Image.fromURL url, (oImg) =>
            @canv.add oImg
        undefined
    addShapeElement: ->
        newShapeElement = new fabric.Circle(
                radius: 100,
                fill: '#d88',
            )
        @canv.add newShapeElement
        undefined
    addLineElement: ->
        newLineElement = new fabric.Text(
                p: v
            )
        undefined
    addHeadingElement: ->
        newHeadingElement = new fabric.Text(
                p: v
            )
        undefined
    addSubheadingElement: ->
        newSubheadingElement = new fabric.Text(
                p: v
            )
        undefined
    setPageBackground: ->
        pageRect = new fabric.Rect()
        undefined
