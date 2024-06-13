const myLabel = Widget.Label({
    label: 'some example content',
})

Utils.interval(1000, () => {
  myLabel.label = Utils.exec('date')
})

const myBar = Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    child: myLabel,
})

App.config({ windows: [myBar] })

console.log("BAR");
