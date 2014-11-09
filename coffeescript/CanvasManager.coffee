class CanvasManager
    constructor: (@canvas_elem, @pg_dimensions) ->
        @page_count = 0
        @top_pg_margin = 20
        @pixel_scale = 1
        $(@canvas_elem).bind 'dragover', (e) =>
            x_pos = e.originalEvent.clientX - @canvas_elem.getBoundingClientRect().left
            y_pos = e.originalEvent.clientY - @canvas_elem.getBoundingClientRect().top
            console.log '('+x_pos+ ', '+y_pos+')'
            e.stopPropagation()
            e.preventDefault()
        scale_ratio = 1
        if window.devicePixelRatio > 1
            scale_ratio = window.devicePixelRatio
            @pixel_scale = window.devicePixelRatio
        canv_w = $(@canvas_elem).width()
        canv_h = $(@canvas_elem).height()
        @canvas_elem.width = canv_w * scale_ratio
        @canvas_elem.height = canv_h * scale_ratio
        @addPage(null)
        @addPage(null)
        undefined

    addPage: (page) ->
        canv_w = $(@canvas_elem).width()
        pg_x = ((canv_w/2)-(@pg_dimensions.x/2))
        pg_y = @top_pg_margin+@page_count*(@top_pg_margin+@pg_dimensions.y)
        ctx = @canvas_elem.getContext '2d'
        ctx.fillStyle = '#ffffff'
        ctx.fillRect(pg_x*@pixel_scale,
                     pg_y*@pixel_scale,
                     @pg_dimensions.x*@pixel_scale,
                     @pg_dimensions.y*@pixel_scale)
        ctx.save()
        @canvas_elem.height =  + (canv_h * scale_ratio)
        @page_count += 1
        undefined

