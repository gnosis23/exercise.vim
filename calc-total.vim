vim9script

const TAX_RATE: float = 0.085

def CalculateTotal(price: float, quantity: number): float
    const base_total: float = price * quantity
    const final_total: float = base_total * (1.0 + TAX_RATE)

    return final_total
enddef

def CheckAndCallTotal(price_str: string, quantity_str: string): float
    return CalculateTotal(str2float(price_str), str2nr(quantity_str))
enddef

command! -nargs=* PriceCheck echom string(CheckAndCallTotal(<f-args>))

