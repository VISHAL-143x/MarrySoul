import React, { useState } from "react"
import UAuth from "@uauth/js"
import { Button } from "react-bootstrap"

const uauth = new UAuth({
    clientID: "25253022-ca91-45b4-9691-02bcd4a876e2",
    redirectUri: "http://localhost:3000",
})

function UDomain() {
    const [Uauth, setUauth] = useState()

    async function Connect() {
        try {
            const authorization = await uauth.loginWithPopup()
            setUauth(JSON.parse(JSON.stringify(authorization))["idToken"])

            // eslint-disable-next-line no-undef
            await authenticate()
        } catch (error) {
            console.error(error)
        }
    }

    async function logOut() {
        uauth.logout()
        logOut()
    }

    function log() {
        if (Uauth === null || Uauth === undefined) {
            Connect()
        } else {
            logOut()
        }
    }

    return (
        <>
            <Button className="UDomain" onClick={log}>{Uauth != null ? Uauth["sub"] : "Login with UNSD"}</Button>
        </>
    )
}

export default UDomain