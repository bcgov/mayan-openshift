from mayan.apps.forms import form_widgets


def render_radio_option(
    label, name, value, attrs=None, index=0, selected=False
):
    attrs = attrs or {}
    widget = form_widgets.RadioSelect()

    option = widget.create_option(
        attrs=attrs, index=index, label=label, name=name, selected=selected,
        subindex=None, value=value,
    )

    return widget._render(
        context={'widget': option}, template_name=widget.option_template_name
    )
