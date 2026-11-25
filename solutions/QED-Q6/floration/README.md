Look at vertex 0: its 5 other vertices split into neighbours and non-neighbours, so one side has
at least 3 vertices x, y, z (`Finset.two_lt_card`). If any pair among them is adjacent (resp.
non-adjacent) it forms a triangle (resp. independent set) with 0; otherwise x, y, z themselves do.
