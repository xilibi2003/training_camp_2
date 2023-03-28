import { defineConfig } from '@wagmi/cli'
import { erc, react } from '@wagmi/cli/plugins'

export default defineConfig({
  out: 'src/generated.ts',
  plugins: [erc(), react()],
})
