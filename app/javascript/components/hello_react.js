import React from 'react'
import ReactDOM from 'react-dom'
import h from "./htm_create_element"

const Hello = props => (
  h `<div>Hello ${props.name}</div>`
  // React.createElement('div', null, `Hello ${props.name}`)
)

// Hello.defaultProps = {
//   name: 'David'
// }

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    h `<${Hello} name="Rails 7" />`,
    document.getElementById('app'),
  )
})

// React.createElement(Hello, {name: 'Rails 7'}, null),
