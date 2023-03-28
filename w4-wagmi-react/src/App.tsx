import { useAccount } from 'wagmi'

import { Account, Connect, ERC20, NetworkSwitcher } from './components'

export function App() {
  const { isConnected } = useAccount()

  return (
    <>
      <h1>wagmi + ERC20 + Vite</h1>

      <Connect />

      {isConnected && (
        <>
          <Account />
          <ERC20 />
          <NetworkSwitcher />
        </>
      )}
    </>
  )
}
