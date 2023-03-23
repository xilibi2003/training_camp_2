  export function premitTypedDate(tokenName, verifyAddr, owner, spender, value, deadline, chainid, nonce) {
      let types = {
        EIP712Domain: [{
            name: 'name',
            type: 'string'
          },
          {
            name: 'version',
            type: 'string'
          },
          {
            name: 'chainId',
            type: 'uint256'
          },
          {
            name: 'verifyingContract',
            type: 'address'
          },
        ],
        Permit: [{
            name: 'owner',
            type: 'address'
          },
          {
            name: 'spender',
            type: 'address'
          },
          {
            name: 'value',
            type: 'uint256'
          },
          {
            name: 'nonce',
            type: 'uint256'
          },
          {
            name: 'deadline',
            type: 'uint256'
          }
        ]
      };

      let primaryType = 'Permit';
      let domain = {
        name: tokenName,
        version: '1',
        chainId: chainid,
        verifyingContract: verifyAddr
      };
      let message = {
        owner,
        spender,
        value,
        nonce,
        deadline
      };

      return JSON.stringify({
        types,
        primaryType,
        domain,
        message
      });
    }