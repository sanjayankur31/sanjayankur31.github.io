Plain text accounting: generating graphs from ledger-cli
########################################################
:date: 2022-04-17 17:32:37
:modified: 2022-04-17 17:32:37
:author: ankur
:category: Tech
:tags: accounting, ledger-cli, finances, gnuplot, fedora
:slug: plaintext-accounting-generating-graphs-from-ledger-cli-data
:summary: Some notes on generating graphs for finances tracked with `ledger-cli`_.


.. raw:: html

   <center>

.. figure:: {static}/images/20220417-savings.jpg
    :alt: Photo by micheile dot com on Unsplash.
    :width: 80%
    :class: img-responsive
    :target: #

    Photo by `micheile dot com <https://unsplash.com/@micheile?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText>`__ on `Unsplash <https://unsplash.com/s/photos/savings?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText>`__.

.. raw:: html

   </center>


There are a number of tools for personal financing.
`GNUCash <https://www.gnucash.org/>`__ is a rather well known one.
For those of us that prefer the command line and plan text accounting, though, the go-to tool is `ledger-cli`_.
Both are available in the `Fedora repos <https://packages.fedoraproject.org/pkgs/ledger/ledger/>`__:

.. code:: console

    sudo dnf install gnucash ledger


There's plenty of documentation for `plain text accounting <https://plaintextaccounting.org/>`__ and `ledger-cli`_ if you'd like to take a look.
The idea is to write transactions in a plain text file, for example (from the `ledger-cli`_ documentation):

.. code::


    2012-03-10 KFC
        Expenses:Food                $20.00
        Assets:Cash                 $-20.00


Since it's `double entry bookkeeping <https://en.wikipedia.org/wiki/Double-entry_bookkeeping>`__, each transaction must have a debit and credit so that the transaction is balanced.

To get the balances of different accounts, or to see transactions, one can then use the :code:`ledger` command.
Examples (also from the documentation):

.. code:: console

    $ ledger balance -f <name of ledger file> <account name>

             $ -3,804.00  Assets
              $ 1,396.00    Checking
                 $ 30.00      Business
             $ -5,200.00    Savings
             $ -1,000.00  Equity:Opening Balances
              $ 6,654.00  Expenses
              $ 5,500.00    Auto
                 $ 20.00    Books
                $ 300.00    Escrow
                $ 334.00    Food:Groceries
                $ 500.00    Interest:Mortgage
             $ -2,030.00  Income
             $ -2,000.00    Salary
                $ -30.00    Sales
                $ -63.60  Liabilities
                $ -20.00    MasterCard
                $ 200.00    Mortgage:Principal
               $ -243.60    Tithe
    --------------------
               $ -243.60


    $ ledger register -f <name of ledger file> <account name>

    10-Dec-01 Checking balance      Assets:Checking          $ 1,000.00   $ 1,000.00
                                    Equit:Opening Balances  $ -1,000.00            0
    10-Dec-20 Organic Co-op         Expense:Food:Groceries      $ 37.50      $ 37.50
                                    Expense:Food:Groceries      $ 37.50      $ 75.00
                                    Expense:Food:Groceries      $ 37.50     $ 112.50
                                    Expense:Food:Groceries      $ 37.50     $ 150.00
                                    Expense:Food:Groceries      $ 37.50     $ 187.50
                                    Expense:Food:Groceries      $ 37.50     $ 225.00
                                    Assets:Checking           $ -225.00            0
    10-Dec-28 Acme Mortgage         Lia:Mortgage:Principal     $ 200.00     $ 200.00
                                    Expe:Interest:Mortgage     $ 500.00     $ 700.00
                                    Expenses:Escrow            $ 300.00   $ 1,000.00
                                    Assets:Checking         $ -1,000.00            0
    11-Jan-02 Grocery Store         Expense:Food:Groceries      $ 65.00      $ 65.00
                                    Assets:Checking            $ -65.00            0
    11-Jan-05 Employer              Assets:Checking          $ 2,000.00   $ 2,000.00
                                    Income:Salary           $ -2,000.00            0
                                    (Liabilities:Tithe)       $ -240.00    $ -240.00
    11-Jan-14 Bank                  Assets:Savings             $ 300.00      $ 60.00
                                    Assets:Checking           $ -300.00    $ -240.00
    11-Jan-19 Grocery Store         Expense:Food:Groceries      $ 44.00    $ -196.00
                                    Assets:Checking            $ -44.00    $ -240.00
    11-Jan-25 Bank                  Assets:Checking          $ 5,500.00   $ 5,260.00
                                    Assets:Savings          $ -5,500.00    $ -240.00
    11-Jan-25 Tom's Used Cars       Expenses:Auto            $ 5,500.00   $ 5,260.00
                                    Assets:Checking         $ -5,500.00    $ -240.00
    11-Jan-27 Book Store            Expenses:Books              $ 20.00    $ -220.00
                                    Liabilities:MasterCard     $ -20.00    $ -240.00
    11-Dec-01 Sale                  Asse:Checking:Business      $ 30.00    $ -210.00
                                    Income:Sales               $ -30.00    $ -240.00
                                    (Liabilities:Tithe)         $ -3.60    $ -243.60



There's a lot more that :code:`ledger` can do, so do check the man page at :code:`man ledger` for more information.

Generating graphs
------------------

For my personal finance reports, I have a shell script that I use to get various balances and transactions.
It's just a set of :code:`ledger` commands really.

To get an idea of trends, though---if one's assets/savings are increasing, for example---graphs are a much better tool.
When looking for ways of generating graphs from :code:`ledger` I ran into `this page <https://www.sundialdreams.com/report-scripts-for-ledger-cli-with-gnuplot/>`__ which basically covers the whole flow.
It even uses `Gnuplot`_, which is also my tool of choice!

So everything I'm noting here is based on this original, awesome, resource, and I'm eternally grateful 

:code:`ledger` has a number of options that make it easy to generate data for easy plotting:

- `--monthly` to report monthly values
- `--collapse` to show only the top level accounts
- `--amount-data` to show only dates and values instead of the full register report as shown in the above example

So a command like this will generate two column output that we can redirect to a file:

.. code:: console

    ledger -f <ledger file> --amount-data reg Expenses --monthly --collapse > filename.txt

    2020-01-01 1234.00
    2020-02-01 5678.00
    ...
    ...


This can then be used as input for different graphing tools.
I use `Gnuplot`_ for my work, but any plotting tool will do---a spreadsheet like `Libreoffice Calc <https://www.libreoffice.org/discover/calc/>`__ or even `Matplotlib <https://matplotlib.org>`__ if you'd prefer to write Python scripts.


.. _ledger-cli: https://www.ledger-cli.org/
.. _Gnuplot: http://gnuplot.sourceforge.net/
