export default {
  title: 'VitePress Site',
  description: 'A VitePress site',
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Hello', link: '/hello' }
    ],
    sidebar: [
      {
        text: 'Guide',
        items: [
          { text: 'Home', link: '/' },
          { text: 'Hello', link: '/hello' }
        ]
      }
    ]
  }
}