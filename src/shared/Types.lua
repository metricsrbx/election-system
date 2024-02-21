--!strict

--[[
	Stores common type information used internally.

	These types may be used internally so the code can type-check, but
	should never be exposed to public users, as these definitions are fair game
	for breaking changes.
]]

-- Stores useful information about Luau errors.
export type Error = {
	type: string, -- replace with "Error" when Luau supports singleton types
	raw: string,
	message: string,
	trace: string
}

return nil
