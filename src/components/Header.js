import React from "react";
import BasicLogo from "../assets/nfthack-logo.svg";

const Header = () => {
  return (
    <>
     
        <img alt="Logo" style={{ height: "150px" }} src={BasicLogo}></img>
      <p className="header gradient-text">Welcome to AcademicNFT! </p>
      <p className="sub-text gradient-text">
        AcademicNFT is a permissionless soulbound token issuing/attesting(minting)
        protocol. <br />
         You’re welcome to issue souldbound certification token to friends and
        community 
      </p>
      <div id="hackNotify"></div>
    </>
  );
};

export default Header;
