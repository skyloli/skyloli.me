import React from "react"

const Gtag = () => {
    return (
      <>
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-4EMLPCS7L0"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments)}
          gtag('js', new Date());

          gtag('config', 'G-4EMLPCS7L0');
        </script>
      </>
    )
}

export default Gtag