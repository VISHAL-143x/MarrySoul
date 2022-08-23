
import React from "react"
import UDomain from "./UDomain";

const ConnectWalletButton = ({connectWallet, ...props}) => {
  return (
    <>
    <button
    onClick={connectWallet}
    className="cta-button connect-to-wallet-button"
  >
    Connect to Wallet
  </button>, 
  
  <UDomain/>
    </>
  )
}

export default ConnectWalletButton;