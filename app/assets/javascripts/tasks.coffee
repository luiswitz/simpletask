class TaskList
  constructor: (item) ->
    @item = $(item)
    @tasks = $.map @item.find("[data-behavior='task']"), (item, i) ->
      new Task(item)

class Task
  constructor: (item) ->
    @item = $(item)
    @id = @item.data("id")
    @setEvents()

  setEvents: ->
    @item.find("[data-behavior='task-toggle']").on "click", @handleToggle
    @item.find("[data-behavior='task-description'] p").on "click", @handleEdit
    @item.find("[data-behavior='edit-task-field']").on "focusout", @handleUpdate

  handleToggle: =>
    $.ajax(
      url: "/tasks/#{@id}/complete",
      method: "PATCH",
      dataType: "JSON",
      success: @handleToggleSuccess
    )

  handleEdit: =>
    @item.find("[data-behavior='edit-task-field']").show()
    @item.find("[data-behavior='task-description'] p").hide()

  handleUpdate: =>
    description = @item.find("[data-behavior='edit-task-field']").val()
    $.ajax(
      url: "/tasks/#{@id}",
      method: "PUT",
      dataType: "JSON",
      data: { task: { id: @id, description: description } }
      success: @handleUpdateSuccess,
      error: @handleUpdateError
    )

  handleUpdateSuccess: (data) =>
    @item.find("[data-behavior='edit-task-field']").hide()
    @item.find("[data-behavior='task-description'] p").show()
    @item.find("[data-behavior='task-description'] p").text data.description

  handleUpdateError: (data) =>
    alert data.responseJSON.description
    @item.find("[data-behavior='edit-task-field']").hide()
    @item.find("[data-behavior='task-description'] p").show()

  handleToggleSuccess: (data) =>
    if data.completed
      @item.find("[data-behavior='task-description'] p").html "<del>#{data.description}</del>"
      @item.find("[data-behavior='task-toggle']").html "<i class='fa fa-check-square-o'></i>"
    else
      @item.find("[data-behavior='task-description'] p").html data.description
      @item.find("[data-behavior='task-toggle']").html "<i class='fa fa-square-o'></i>"


jQuery ->
  new TaskList $("[data-behavior='task-list']")
