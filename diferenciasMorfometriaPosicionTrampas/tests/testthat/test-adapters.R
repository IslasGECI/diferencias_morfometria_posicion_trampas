describe("Adapter for splited trap daily status", {
  data_path <- "/workdir/diferenciasMorfometriaPosicionTrampas/tests/data_tests/traps_daily_status_guadalupe.csv"
  it("split id", {
    obtained <- split_id(data_path)
  })
})
