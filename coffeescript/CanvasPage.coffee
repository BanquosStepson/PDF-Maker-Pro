class CanvasPage
    constructor: (@pg_dimensions, @pg_num) ->
        @canv = null

    setCanvasElement: (elem) ->
        # console.log $(elem)
        parent = $(elem).parent()
        @canv_w = parent_w = parent.width()
        @canv_h = parent_h = parent.height()
        @pg_vertical_padding = 20
        @pg_horizontal_padding = (@canv_w-@pg_dimensions.x)/2
        @canv = new fabric.Canvas(elem)
        @canv.setWidth parent_w
        @canv.setHeight parent_h
        console.log parent_h
        @canv.renderAll()
        @setPageBackground()
        # @setMarginLines()
        @registerInternalInteractionEvents()
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
        sampleText = 'Double click text to edit'
        newTextElement = new fabric.IText sampleText,
            left: coords.x
            top: coords.y
            originX: 'center'
            originY: 'center'
            fontSize: 16
            hasControls: false
            # fill: 'purple' # text-color
        @canv.add newTextElement
        @fixElementPosition newTextElement
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
            @fixElementPosition oImg
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
        @fixElementPosition newShapeElement
        undefined
    addLineElement: (coords) ->
        coords = [coords.x, coords.y, coords.x+100, coords.y]
        newLineElement = new fabric.Line(coords,
                stroke: '#000000'
                strokeWidth: 3
                lockScalingY: true
                hasControls: false
                borderColor: '#ff9800'
                originX: 'center'
                originY: 'center'
                padding: 2
            )
        @canv.add newLineElement
        @fixElementPosition newLineElement
        undefined
    addHeadingElement: (coords) ->
        sampleText = 'Heading (doubleclick to edit)'
        newHeadingElement = new fabric.IText sampleText,
            left: coords.x
            top: coords.y
            originX: 'center'
            originY: 'center'
            fontSize: 36
            hasControls: false
            # fill: 'purple' # text-color
        @canv.add newHeadingElement
        @fixElementPosition newHeadingElement
        undefined
    addSubheadingElement: (coords) ->
        sampleText = 'Subheading (doubleclick to edit)'
        newSubheadingElement = new fabric.IText sampleText,
            left: coords.x
            top: coords.y
            originX: 'center'
            originY: 'center'
            fontSize: 20
            hasControls: false
            # fill: 'purple' # text-color
        @canv.add newSubheadingElement
        @fixElementPosition newSubheadingElement
        undefined
    fixElementPosition: (elem) ->
        leftPos = elem.left-elem.width/2
        rightPos = leftPos + elem.width
        topPos = elem.top-elem.height/2
        bottomPos = topPos + elem.height
        if leftPos < @pg_horizontal_padding
            elem.left = @pg_horizontal_padding + elem.width/2
        if topPos < @pg_vertical_padding
            elem.top = @pg_vertical_padding + elem.height/2
        if rightPos > @pg_horizontal_padding + @pg_dimensions.x
            elem.left = @canv_w - @pg_horizontal_padding - elem.width/2
        if bottomPos > @pg_vertical_padding + @pg_dimensions.y
            elem.top = @canv_w - @pg_vertical_padding - elem.height/2
        elem.setCoords()
        @canv.renderAll()
        undefined
    registerInternalInteractionEvents: ->
        @canv.on 'object:moving', (e) =>
            # set page bounds
            target = e.target
            width = target.currentWidth
            height = target.currentHeight
            top = target.top - height/2
            left = target.left - width/2
            rightBound = @pg_dimensions.x + @pg_horizontal_padding
            bottomBound = @pg_dimensions.y + @pg_vertical_padding
            if top + height/2 < @pg_vertical_padding
                top = @pg_vertical_padding
                target.setTop top
            if left + width/2 < @pg_horizontal_padding
                left = @pg_horizontal_padding
                target.setLeft left
            if left + width/2 > rightBound
                left = rightBound
                target.setLeft left
            if top + height/2 > bottomBound
                top = bottomBound
                target.setTop top
        @canv.on 'object:selected', (e) =>
            switch e.target.type
                when 'i-text'
                    undefined
                when 'image'
                    undefined
                when 'circle'
                    undefined
                when 'line'
                    undefined
                when 'heading'
                    undefined
                when 'subheading'
                    undefined
        undefined
    setPageBackground: ->
        page_center_x = (@canv_w - @pg_dimensions.x)/2
        pageRect = new fabric.Rect(
                width: @pg_dimensions.x
                height: @pg_dimensions.y
                left: page_center_x
                top: @pg_vertical_padding
                fill: '#ffffff'
                borderColor: 'blue'
                selectable: false
            )
        pageRect.setShadow "0 4px 10px rgba(0, 0, 0, 0.33)"
        pageRect.hasControls = false
        @canv.add pageRect
        undefined
    setMarginLines: ->
        console.log 'setting margin lines'
        margin_amount = 50
        line_opts =
            stroke: 'rgba(36, 166, 227, 0.33)'
            strokeWidth: 1
            lockScalingY: true
            hasControls: false
            originX: 'center'
            originY: 'center'
            padding: 2
            selectable: false
        coords = [0, @pg_vertical_padding+margin_amount, @canv_w, @pg_vertical_padding+margin_amount]
        @margin_top = new fabric.Line coords, line_opts
        coords = [@pg_horizontal_padding+margin_amount, 0, @pg_horizontal_padding+margin_amount, @canv_h]
        @margin_left = new fabric.Line coords, line_opts
        coords = [0, @canv_h-@pg_vertical_padding-margin_amount, @canv_w, @canv_h-@pg_vertical_padding-margin_amount]
        @margin_bottom = new fabric.Line coords, line_opts
        coords = [@canv_w-@pg_horizontal_padding-margin_amount, 0, @canv_w-@pg_horizontal_padding-margin_amount, @canv_h]
        @margin_right = new fabric.Line coords, line_opts
        @canv.add @margin_top
        @canv.add @margin_left
        @canv.add @margin_bottom
        @canv.add @margin_right
        undefined
    removeMarginLines: ->
        @canv.remove @margin_top
        @canv.remove @margin_left
        @canv.remove @margin_bottom
        @canv.remove @margin_right
        undefined
    getSelectedElement: ->
        return @canv.getActiveObject()
