jQuery.turboload = (fn, namespace = 'renuo') ->
  $(document).ready(fn)
  $(document).on('page:load' + '.' + namespace, fn)

# unregister (direct) event handlers that were registered during parsing the body
# if not unregistered they would remain registered after body unload and on body reload they would get registered twice
$(document).on('page:fetch', ->
  $(document).off('page:load.body')
)

renuo = window.oolino = window.oolino || {}

renuo.pageReady = ->

renuo.pageLoad = ->

  CKEDITOR.disableAutoInline = true;

  $('.editable').each ->

    CKEDITOR.inline(
      this,
      on:
        blur: (e) ->
          return unless e.editor.checkDirty()

          new_content = e.editor.getData()
          $element = $(e.editor.element.$)
          url = $element.data('update-url')
          field = $element.data('field')
          data = {
            '_method': 'put'
          }
          data["#{field}"] = new_content
          $.ajax
            url: url
            data: data
            method: 'POST'
            success: (data, status, xhr) ->
              $element.removeClass("has-error")
              $element.addClass("update-success")
              setTimeout ->
                  $element.removeClass("update-success")
                , 2000
            error: (xhr, status, error) ->
              $element.removeClass("update-success")
              $element.addClass("has-error")
    )


$.turboload(renuo.pageLoad)
$(document).ready(renuo.pageReady)
$(document).on('ajaxSuccess', renuo.pageLoad)