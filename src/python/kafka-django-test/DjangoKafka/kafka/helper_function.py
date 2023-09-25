def is_first_load():
    FIRST_LOAD = 0
    def inner():
        nonlocal FIRST_LOAD
        if FIRST_LOAD < 1:
            FIRST_LOAD += 1
            return True
        else:
            return False
    return inner

