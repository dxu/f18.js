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

  context.globalCompositeOperation = 'lighter'  # exclusion and difference also looks cool

  {count} = opts
  count = canvas.width * canvas.height / 800
  console.log count
  for index in [0...count]
    console.log 'drawing polygon ', index
    # generate a random x and y within
    bounds = [0,canvas.width]
    [x, y] = [Math.random() * canvas.width, Math.random() * canvas.height]

    edges = opts.minEdges + Math.random() * (opts.maxEdges - opts.minEdges)
    startAngle = Math.random() * 2 * Math.PI
    angle = 2 * Math.PI / edges


    {minRadius, maxRadius} = opts
    unless minRadius and maxRadius
      # set radius as a function of size. Shouldn't be bigger than a third
      minRadius = 5
      maxRadius = Math.min(canvas.width,canvas.height) * 1/10

    radius = randomValueBetween minRadius, maxRadius
    alpha = randomValueBetween(5, 30) / 100
    hue = randomValueBetween 180, 360
    lightness = randomValueBetween 1, 30
    saturation = randomValueBetween 10, 30


    fillColor = "hsla(#{hue}, #{saturation}%, #{lightness}%, #{alpha})"
    strokeColor = "hsla(#{hue}, #{saturation}%, #{lightness}%, #{alpha})"
    shadowColor = "hsla(#{hue*2}, #{saturation*2}%, #{lightness*2.5}%, #{alpha * 3})"
    shadowBlur = randomValueBetween radius, canvas.width
    lineWidth = 0

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
    # context.stroke()
    context.fill()

document.addEventListener 'DOMContentLoaded', (evt) ->

  canvas = document.getElementById('canvas')
  width = canvas.width = canvas.innerWidth = window.innerWidth
  height = canvas.height = canvas.innerHeight = window.innerHeight

  bokehItUp canvas,
    count: 150
    minEdges: 6
    maxEdges: 15
    # minRadius: 5
    # maxRadius: 300

