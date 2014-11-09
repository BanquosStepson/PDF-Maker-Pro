
$(document).ready ->
    $('.main-app-container .app-toolbar button').tooltip()

    canvas_drag = (e) ->
        element_name = $(e.target).parent().attr('data-element-name')
        e.originalEvent.dataTransfer.setData('text/plain', element_name)
        console.log "drag :: " + element_name
        undefined

    canvas_drop = (e) ->
        e.stopPropagation()
        e.preventDefault()
        console.log 'drop :: '
        console.log e.originalEvent.dataTransfer.getData('text/plain')
        undefined

    canvas_ignore_drag = (e) ->
        e.stopPropagation()
        e.preventDefault()
        undefined

    $('.main-app-container .pdf-element-inner-wrap').bind('dragstart', canvas_drag)
    $('.main-app-container .pdf-maker-canvas').bind('dragenter', canvas_ignore_drag)
        .bind('dragover', canvas_ignore_drag)
        .bind('drop', canvas_drop)

    return