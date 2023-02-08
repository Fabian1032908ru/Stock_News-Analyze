"""
Train data
"""

train_data_str = [
    "Samsung declares bankruptcy",
    "Samsung on the brink: Stock prices plummet",
    "Samsung announces mass lay-offs amid financial crisis",
    "Experts question future of Samsung as debt continues to mount",
    "Samsung faces major lawsuit over alleged mismanagement",

    "Samsung forced to sell key assets to stay afloat",
    "Financial turmoil at Samsung sends shockwaves through tech industry",
    "Samsung's creditors scramble to recoup losses as company struggles to pay debts",
    "Once-mighty Samsung reduced to seeking bailout from government",
    "Samsung's future in doubt as industry leaders express concerns over ability to recover",

    "Samsung introduces breakthrough technology for home appliances",
    "Samsung's Galaxy smartphone series sees record sales in Q4",
    "Samsung invests in AI research and development",
    "Samsung partners with leading car manufacturers for connected vehicles",
    "Samsung launches new line of premium laptops",

    "Samsung opens state-of-the-art manufacturing facility in Southeast Asia",
    "Samsung collaborates with leading software companies to enhance product offerings",
    "Samsung named one of the world's most innovative companies by Forbes",
    "Samsung releases highly anticipated Galaxy Watch",
    "Samsung dominates global TV market with new QLED line",

    "Samsung named as world's leading brand for customer satisfaction",
    "Samsung introduces groundbreaking virtual reality technology",
    "Samsung dominates smart home market with new Internet of Things products",
    "Samsung sets new standards in mobile photography with latest Galaxy camera technology",
    "Samsung announces partnership with top universities to drive technological innovation",

    "Samsung leads the way in 5G research and development",
    "Samsung named as most environmentally friendly company in the tech industry",
    "Samsung earns praise for commitment to diversity and inclusion in the workplace",
    "Samsung collaborates with global humanitarian organizations to bring technology to "
    "underserved communities",
    "Samsung receives prestigious award for corporate social responsibility initiatives",

]
train_data_int = [
    -1, -1, -1, -1, 5, 1, 0, 2, 1, 1, 60, 70, 50, 30, 44, 42, 38, 72, 65, 55, 61, 66, 53, 81, 57,
    59, 52, 49, 45, 43
]
print(len(train_data_int))
print(len(train_data_str))
