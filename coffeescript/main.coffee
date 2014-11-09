$(document).ready ->
    $('.main-app-container .app-toolbar button').tooltip()

    element_drag = (e) ->
        element_name = $(e.target).parent().attr('data-element-name')
        dragged_el = $(e.target)
        e.originalEvent.dataTransfer.setData('text/plain', element_name)
        canv = $('.pdf-maker-canvas-wrap .panel-body')
        canv.addClass 'dragging'
        dragged_el.addClass 'dragging'
        undefined

    element_end_drag = (e) ->
        dragged_el = $(e.target)
        canv = $('.pdf-maker-canvas-wrap .panel-body')
        canv.removeClass 'dragging'
        dragged_el.removeClass 'dragging'
        undefined

    canvas_drop = (e) ->
        e.stopPropagation()
        e.preventDefault()
        dropped_element = e.originalEvent.dataTransfer.getData('text/plain')
        # console.log dropped_element
        # switch dropped_element
        #     when dropped_element is ''
        undefined

    canvas_change_drag_img = (e) ->
        canvas_ignore_drag(e)
        console.log 'over'
        undefined

    canvas_ignore_drag = (e) ->
        e.stopPropagation()
        e.preventDefault()
        undefined

    main = ->
        $('.main-app-container .pdf-element-inner-wrap').bind('dragstart', element_drag)
            .bind('dragend', element_end_drag)
        $('.main-app-container .pdf-maker-canvas').bind('dragenter', canvas_change_drag_img)
            .bind('dragover', canvas_ignore_drag)
            .bind('drop', canvas_drop)
        canvas_elem = document.getElementById 'pdf-maker-canvas'
        new CanvasPdfDocument(canvas = canvas_elem, title = 'bob')
        undefined
    main()
    return