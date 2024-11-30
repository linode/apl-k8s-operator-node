// @ts-check

import eslint from '@eslint/js'
import tseslint from 'typescript-eslint'

const config = tseslint.config(eslint.configs.recommended, ...tseslint.configs.recommended)

config.push({ rules: { '@typescript-eslint/ban-ts-comment': 'error' } })

export default config
