randomValueBetween = (min, max) ->
  return min + Math.random() * (max - min)

###
# opts:
#   count: number of bokeh
#   edges: number of edges. Anything lower than 5 will default to a circle
#     ** pass in a tuple, let it be a range?
#   startRadius (optional):
#   endRadius:
###
bokehItUp = (canvas, opts) ->
  context = canvas.getContext '2d'
  context.globalCompositeOperation = 'difference'
  context.strokeStyle = 'white'
  console.log 'hello'
  for index in [0...opts.count]
    console.log 'hello', index
    # generate a random x and y within
    bounds = [0,canvas.width]
    [x, y] = [Math.random() * canvas.width, Math.random() * canvas.height]

    edges = opts.minEdges + Math.random() * (opts.maxEdges - opts.minEdges)
    startAngle = Math.random() * 2 * Math.PI
    angle = 2 * Math.PI / edges
    radius = opts.minRadius + Math.random() * (opts.maxRadius - opts.minRadius)

    alpha = randomValueBetween 5, 30/100
    hue = randomValueBetween 200, 360
    lightness = randomValueBetween 1, 30
    saturation = randomValueBetween 10, 50


    fillColor = "hsla(#{hue}, #{saturation}%, #{lightness}%, #{alpha})"
    strokeColor = "hsla(#{hue}, #{saturation}%, #{lightness}%, #{alpha})"
    shadowColor = "hsla(#{hue}, #{saturation * 2}%, #{lightness * 2}%, #{alpha * 2.5})"

    shadowBlur = radius/2
    lineWidth = radius/40

    context.fillStyle = fillColor
    context.shadowColor = shadowColor
    context.shadowBlur = shadowBlur
    context.strokeStyle = strokeColor
    context.lineWidth = lineWidth

    context.beginPath()
    context.save()
    context.translate(x,y)
    context.rotate(startAngle)
    context.moveTo(radius, 0)
    for edge in [0..edges]
      context.lineTo(radius * Math.cos(angle * edge), radius * Math.sin(angle * edge))
    context.closePath()
    context.restore()
    context.stroke()
    context.fill()

document.addEventListener 'DOMContentLoaded', (evt) ->

  canvas = document.getElementById('canvas')
  width = canvas.width = canvas.innerWidth = window.innerWidth
  height = canvas.height = canvas.innerHeight = window.innerHeight

  bokehItUp canvas,
    count: 50
    minEdges: 5
    maxEdges: 15
    minRadius: 5
    maxRadius: 300

