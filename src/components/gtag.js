import React from "react"
import Helmet from "react-helmet";

const Gtag = () => {
  return (
    <div>
      <Helmet>
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-4EMLPCS7L0"></script>
        <script>
          window.dataLayer = window.dataLayer || []
          function gtag(){dataLayer.push(arguments)}
          gtag('js', new Date())

          gtag('config', 'G-4EMLPCS7L0')
        </script>
      </Helmet>
    </div>
  )
}

export default Gtag