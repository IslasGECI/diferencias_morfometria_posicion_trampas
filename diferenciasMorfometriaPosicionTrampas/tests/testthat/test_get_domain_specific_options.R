describe("Get domain specific language options", {
  obtained_options <- get_domain_specific_options()
  expected_options <- c("trap-positions-path", "output-path")
  expect_true(all(expected_options %in% obtained_options))
})
