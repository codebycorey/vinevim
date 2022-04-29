local schemas_ok, schemastore = pcall(require, "schemastore")
if not schemas_ok then
    return {}
end

return {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
        },
    },
}
