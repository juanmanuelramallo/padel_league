const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      white: '#ffffff',
      black: '#000000',
      'primary': {
          '50': '#eff8ff',
          '100': '#def0ff',
          '200': '#b6e2ff',
          '300': '#75ccff',
          '400': '#2cb3ff',
          '500': '#008ee6',
          '600': '#0079d4',
          '700': '#0060ab',
          '800': '#00518d',
          '900': '#064474',
          '950': '#042b4d',
      },
      'secondary': {
        '50': '#fff8ec',
        '100': '#ffefd3',
        '200': '#ffdba5',
        '300': '#ffc06d',
        '400': '#ff9932',
        '500': '#ff7b0a',
        '600': '#e65800',
        '700': '#cc4502',
        '800': '#a1360b',
        '900': '#822f0c',
        '950': '#461504',
      },
      gray: colors.gray,
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
