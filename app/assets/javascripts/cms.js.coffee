$(document).ready ->
  CKEDITOR.disableAutoInline = true;
  CKEDITOR.inline(
    $('.editable')[0]
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
            console.log("success")
            console.log(status)
            $element.removeClass("has-error")
            $element.addClass("update-success")
            setTimeout ->
                $element.removeClass("update-success")
              , 2000
          error: (xhr, status, error) ->
            console.log("error")
            console.log(status)
            $element.removeClass("update-success")
            $element.addClass("has-error")
          statusCode:
            302: (data) ->
              console.log("302 callback")
              console.log(data)
  )