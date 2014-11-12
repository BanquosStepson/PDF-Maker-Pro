class PdfDocument
    constructor: (@title = ''
                  @filename = ''
                  @datecreated = ''
                  @lastmod = ''
                  @pg_dimensions = {}
                  @pages = []
                  @settings = {}) ->
        @pg_dimensions =
            x: 650
            y: 800
        @pages = []
        @addPage new CanvasPage(@pg_dimensions)
        @addPage new CanvasPage(@pg_dimensions)
        @addPage new CanvasPage(@pg_dimensions)
        @addPage new CanvasPage(@pg_dimensions)
        @addPage new CanvasPage(@pg_dimensions)
        @renderPages()
        @registerCanvasDragDropEvents()

    updateTitle: (title) ->
        undefined

    updateFilename: (filename) ->
        undefined

    updateLastMod: (lastMod) ->
        undefined

    addPage: (page) ->
        @pages.push page
        undefined

    updateSettings: (settings) ->
        undefined

    getSettings: ->
        undefined

    getPages: ->
        return @pages

    saveDoc: ->
        undefined

    generateJSON: ->
        undefined

    loadJSON: (json_str) ->
        undefined

    renderPages: ->
        that = @
        for page, i in @pages
            canv_html = """
                <div class="col-xs-12">
                    <div class="panel panel-default pdf-page">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12">
                                    <canvas id="pdf-page-#{ i + 1 }"
                                            class="pdf-maker-canvas"
                                            data-page-num="#{ i + 1 }">
                                    </canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                """
            $('.main-app-container .pdf-maker-canvas-wrap')
                .append canv_html
            page_canvas = document.getElementById "pdf-page-#{ i + 1 }"
            that.pages[i].setCanvasElement page_canvas
            that.pages[i].setPageNumber i + 1
        # console.log @pages
        undefined

    registerCanvasDragDropEvents: ->
        that = @
        $('.main-app-container .pdf-elements-container .pdf-element-inner-wrap')
            .draggable
                revert: true
                zIndex: 99
        $('.pdf-maker-canvas-wrap .pdf-page .pdf-maker-canvas')
            .droppable
                activeClass: 'dragging'
                hoverClass: 'dragging-hover'
                drop: (e, ui) ->
                    dropped_page_num = $(e.target).attr 'data-page-num'
                    elem_type = ui.draggable.parent().attr 'data-element-name'
                    if dropped_page_num != undefined
                        that.pages[dropped_page_num - 1].addDraggedElement elem_type
        undefined