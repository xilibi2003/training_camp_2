import { BigNumber } from 'ethers'
import { useState } from 'react'
import { Address, useAccount, useNetwork, useWaitForTransaction } from 'wagmi'

import {
  useErc20Allowance,
  useErc20Approve,
  useErc20BalanceOf,
  useErc20Name,
  useErc20Symbol,
  useErc20TotalSupply,
  useErc20Transfer,
  usePrepareErc20Approve,
  usePrepareErc20Transfer,
} from '../generated'

export function ERC20() {
  const { address } = useAccount()
  const [contractAddress, setContractAddress] = useState<Address>(
    '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48',
  )

  return (
    <div>
      <h2>ERC20 Contract</h2>
      Contract Address:{' '}
      <input
        onChange={(e) => setContractAddress(e.target.value as Address)}
        style={{ width: 400 }}
        value={contractAddress}
      />
      {contractAddress && (
        <>
          <h3>Info</h3>
          <Name contractAddress={contractAddress} />
          <TotalSupply contractAddress={contractAddress} />
          <BalanceOf address={address} contractAddress={contractAddress} />
          <h3>Transfer</h3>
          <Transfer contractAddress={contractAddress} />
          <h3>Allowance</h3>
          <Allowance address={address} contractAddress={contractAddress} />
        </>
      )}
    </div>
  )
}

function Name({ contractAddress }: { contractAddress: Address }) {
  const { data: name } = useErc20Name({
    address: contractAddress,
  })
  const { data: symbol } = useErc20Symbol({
    address: contractAddress,
  })
  return (
    <div>
      Name: {name} ({symbol})
    </div>
  )
}

function TotalSupply({ contractAddress }: { contractAddress: Address }) {
  const { data: totalSupply } = useErc20TotalSupply({
    address: contractAddress,
  })
  return <div>Total Supply: {totalSupply?.toString()} units</div>
}

function BalanceOf({
  address,
  contractAddress,
}: {
  address?: Address
  contractAddress: Address
}) {
  const { data: balance } = useErc20BalanceOf({
    address: contractAddress,
    args: address ? [address] : undefined,
    watch: true,
  })
  return <div>Balance: {balance?.toString()} units</div>
}

function Allowance({
  address,
  contractAddress,
}: {
  address?: Address
  contractAddress: Address
}) {
  const [amount, setAmount] = useState('')
  const [spender, setSpender] = useState(
    '0xc961145a54C96E3aE9bAA048c4F4D6b04C13916b' as Address,
  )

  const { config, error, isError } = usePrepareErc20Approve({
    address: contractAddress,
    args: spender && amount ? [spender, BigNumber.from(amount)] : undefined,
    enabled: Boolean(spender && amount),
  })
  const { data, write } = useErc20Approve(config)

  const { isLoading, isSuccess } = useWaitForTransaction({
    hash: data?.hash,
  })

  const { data: balance } = useErc20Allowance({
    address: contractAddress,
    args: address && spender ? [address, spender] : undefined,
    watch: true,
  })

  return (
    <div>
      <div>
        Spender:{' '}
        <input
          onChange={(e) => setSpender(e.target.value as Address)}
          placeholder="spender address"
          value={spender}
          style={{ width: 400 }}
        />
      </div>
      <div>
        Set Allowance:{' '}
        <input
          disabled={isLoading}
          onChange={(e) => setAmount(e.target.value)}
          placeholder="amount (units)"
          value={amount}
        />
        <button disabled={isLoading && !write} onClick={() => write?.()}>
          set
        </button>
        {isLoading && <ProcessingMessage hash={data?.hash} />}
        {isSuccess && <div>Success!</div>}
        {isError && <div>Error: {error?.message}</div>}
      </div>
      <div>Allowance: {balance?.toString()}</div>
    </div>
  )
}

function Transfer({ contractAddress }: { contractAddress: Address }) {
  const [address, setAddress] = useState('' as Address)
  const [amount, setAmount] = useState('')

  const { config, error, isError } = usePrepareErc20Transfer({
    address: contractAddress,
    args: address && amount ? [address, BigNumber.from(amount)] : undefined,
    enabled: Boolean(address && amount),
  })
  const { data, write } = useErc20Transfer(config)

  const { isLoading, isSuccess } = useWaitForTransaction({
    hash: data?.hash,
  })

  return (
    <div>
      Transfer:{' '}
      <input
        onChange={(e) => setAddress(e.target.value as Address)}
        placeholder="recipient address"
        value={address}
      />
      <input
        onChange={(e) => setAmount(e.target.value)}
        placeholder="amount (in wei)"
        value={amount}
      />
      <button disabled={!write} onClick={() => write?.()}>
        transfer
      </button>
      {isLoading && <ProcessingMessage hash={data?.hash} />}
      {isSuccess && <div>Success!</div>}
      {isError && <div>Error: {error?.message}</div>}
    </div>
  )
}

function ProcessingMessage({ hash }: { hash?: `0x${string}` }) {
  const { chain } = useNetwork()
  const etherscan = chain?.blockExplorers?.etherscan
  return (
    <span>
      Processing transaction...{' '}
      {etherscan && (
        <a href={`${etherscan.url}/tx/${hash}`}>{etherscan.name}</a>
      )}
    </span>
  )
}
