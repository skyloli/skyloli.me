import React from "react"
import useScript from "../hooks/use-script"

const gtag = useEffect(() => {
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push(arguments)
})

const Gtag = () => {
  useScript("https://www.googletagmanager.com/gtag/js?id=G-4EMLPCS7L0")
  gtag('js', new Date());
  gtag('config', 'G-4EMLPCS7L0');
  console.log("alice foo foo");
  return (
    <div>
    </div>
  )
}

export default Gtag