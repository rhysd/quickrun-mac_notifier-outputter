## mac\_notifier outputter for QuickRun

This is vim-quickrun outputter for MacOS X 10.8.
This plugin outputs result of quickrun executing to a notification.

## Requirement

- vim-quickrun plugin
- OS X (later than OS X 10.8 Mountain Lion)
- terminal-notifier
- vimproc (optional)

## Links

These are links to required stuff.

- https://github.com/thinca/vim-quickrun
- https://github.com/alloy/terminal-notifier
- https://github.com/Shougo/vimproc/

## Usage

`:QuickRun -exec "echo 'Hello, world!'" >mac_notifier -runner vimproc`

To get more information, execute `:help quickrun`

## Customization

- `g:outputter_notifier_title` : Title of notification.
- `g:outputter_notifier_id` : Id of notification. You often need not to care about this.
- `<Plug>(outputter_notifier_remove_notifications)` : keymap for remove the notifications.

## Example

    nmap <Leader>cl <Plug>(outputter_notifier_remove_notifications)
