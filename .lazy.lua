return {
	{
		"codethread/qmk.nvim",
		ft = "dts",
		---@type qmk.UserConfig
		opts = {
			name = "sofle",
			variant = "zmk",
			auto_format_pattern = "*.keymap",
			comment_preview = {
				keymap_overrides = {
					["&trans"] = "",
					["___"] = "",
					["_0_"] = "",
					["&sys_reset"] = "🔄",
					["&bootloader"] = "💾",
					["&studio_unlock"] = "🔓",
					SV_SEMI = ";",
					SV_FSLH = "/",
					SV_QUESTION = "?",
					SV_SLASH = "/",
					SV_BSLH = "\\",
					SV_LBKT = "[",
					SV_PLUS = "+",
					SV_MINUS = "-",
					SV_AT = "@",
					SV_TILDE = "~",
					SV_GRAVE = "`",
					SV_HASH = "#",
					SV_EURO = "€",
					SV_RBKT = "]",
					SV_LBRC = "{",
					SV_RBRC = "}",
					SV_PIPE = "|",
					SV_SQT = "'",
					SV_DOLLAR = "$",
					SV_LT = "<",
					SV_GT = ">",
					SV_EQUAL = "=",
					SV_A_RING = "Å",
					SV_O_UMLAUT = "Ö",
					SV_A_UMLAUT = "Ä",
					["&mkp LCLK"] = "🖱️L",
					["&mkp RCLK"] = "🖱️R",
					["&mkp MCLK"] = "🖱️M",
					-- _MS_.. : mouse scroll
					_MS_U = "🖱️⇈",
					_MS_D = "🖱️⇊",
					_MS_L = "🖱️⇇",
					_MS_R = "🖱️⇉",
					-- _MM_.. : mouse move
					_MM_U = "🖱️↑",
					_MM_D = "🖱️↓",
					_MM_L = "🖱️←",
					_MM_R = "🖱️→",
					SV_EXCL = "!",
					SV_PRCNT = "%",
					SV_CARET = "^",
					C_NEXT = "⏭️",
					C_PREV = "⏮️",
					C_PP = "⏯️",
					BT_NXT = "🛜🔼",
					BT_PRV = "🛜🔽",
					BT_CLR = "🛜❌",
					C_MUTE = "🔇",
					C_VOL_DN = "🔉",
					C_VOL_UP = "🔊",
					C_BRI_UP = "🔆",
					C_BRI_DN = "🔅",
					EP_TOG = "🔌",
					SV_AMPS = "&",
					SV_STAR = "*",
					SV_LPAR = "(",
					SV_RPAR = ")",
					MEH = "MEH",
					K_UNDO = "↩️",
					["COPY"] = "📄",
					["PASTE"] = "📋",
					["CUT"] = "✂️",
					["U_COPY"] = "📄",
					["U_PASTE"] = "📋",
					["U_CUT"] = "✂️",
					["LG(Q)"] = "⌘Q",
					["LC(W)"] = "⌃W",
					["LC(T)"] = "⌃T",
					["LC(TAB)"] = "⌃⇥",
					["LS(LC(TAB))"] = "⇧⌃⇥",
					SPACE = "SPACE",
					KP_MULTIPLY = "*",
					-- use MENU as compose key
					K_CMENU = "🌍",
					K_MENU = "🌍",
					COMPOSE = "🌍",
					LEFT = "←",
					RIGHT = "→",
					UP = "↑",
					DOWN = "↓",
					KP_PLUS = "+",
					SV_DQT = '"',
					PG_UP = "⇞",
					PG_DN = "⇟",
					HOME = "⇱",
					END = "⇲",
					_LTX = "",
					_LMX = "",
					_LBX = "",
					_LHX = "",
					_RTX = "",
					_RMX = "",
					_RBX = "",
					_RHX = "",
					_MTX = "",
					_MMX = "",
					_MBX = "",
					_MHX = "",
				},
				symbols = {
					tl = "╭",
					tr = "╮",
					bl = "╰",
					br = "╯",
				},
			},
			layout = {
				"x x x x x x _ _ _ _ x x x x x x",
				"x x x x x x _ _ _ _ x x x x x x",
				"x x x x x x _ _ _ _ x x x x x x",
				"x x x x x x x _ _ x x x x x x x",
				"_ _ x x x x x _ _ x x x x x _ _",
			},
		},
		config = function(_, opts)
			---@param keymap qmk.KeymapList
			package.loaded["qmk.format.get_key_text"] = function(keymap)
				---@type table<string, string>
				local mapped = {}
				for _, k in ipairs(keymap) do
					mapped[k.key] = k.value
				end
				for _, v in ipairs({ "GUI", "ALT", "CTRL", "SHIFT" }) do
					mapped["R" .. v] = "R" .. v
					mapped["L" .. v] = "L" .. v
				end
				return function(key)
					if mapped[key] then
						return mapped[key]
					end
					local parts = vim.split(key, " ")
					if vim.tbl_contains({ "&kp", "&bt", "&ext_power" }, parts[1]) then
						table.remove(parts, 1)
					end
					for i, part in ipairs(parts) do
						part = mapped[part] or mapped["KC_" .. part] or part
						part = part:gsub("^N(%d)$", "%1")
						if part:find("&") ~= 1 then
							part = part:upper()
						end
						parts[i] = part
					end
					return table.concat(parts, " ")
				end
			end

			require("qmk").setup(opts)
		end,
	},
}
