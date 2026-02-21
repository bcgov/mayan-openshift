from decimal import Decimal
import math

from mayan.apps.testing.tests.base import BaseTestCase

from ..templatetags.templating_math_tags import _process_value

from .mixins import TemplateTestMixin


class ProcessValueTestCase(BaseTestCase):
    def test_int_passthrough(self):
        self.assertEqual(_process_value(5), 5)

    def test_float_passthrough(self):
        self.assertEqual(_process_value(5.25), 5.25)

    def test_decimal_passthrough(self):
        value = Decimal('5.25')
        self.assertEqual(_process_value(value), value)

    def test_string_integer(self):
        self.assertEqual(_process_value('42'), 42)

    def test_string_integer_with_whitespace(self):
        self.assertEqual(_process_value('  42  '), 42)

    def test_string_float(self):
        self.assertEqual(_process_value('3.5'), 3.5)

    def test_string_float_with_whitespace(self):
        self.assertEqual(_process_value('  3.5  '), 3.5)

    def test_none_raises_value_error(self):
        with self.assertRaises(ValueError):
            _process_value(None)

    def test_empty_string_raises_value_error(self):
        with self.assertRaises(ValueError):
            _process_value('')

    def test_non_numeric_string_raises_value_error(self):
        with self.assertRaises(ValueError):
            _process_value('abc')

    def test_unsupported_type_raises_type_error(self):
        with self.assertRaises(TypeError):
            _process_value([])


class TemplateTagMathTestCase(TemplateTestMixin, BaseTestCase):
    def test_add_float(self):
        value_1 = 5.2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1| math_add:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(value_1 + value_2)
        )

    def test_add_integer(self):
        value_1 = 5
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1| math_add:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(value_1 + value_2)
        )

    def test_absolute_float(self):
        value = -2.5
        result = self._render_test_template(
            template_string='{{ value | math_absolute }}',
            context={'value': value}
        )
        self.assertEqual(
            result, str(
                abs(value)
            )
        )

    def test_absolute_integer(self):
        value = -1
        result = self._render_test_template(
            template_string='{{ value | math_absolute }}',
            context={'value': value}
        )
        self.assertEqual(
            result, str(
                abs(value)
            )
        )

    def test_ceil(self):
        result = self._render_test_template(
            template_string='{{ value|math_ceil }}',
            context={'value': 2.1}
        )

        self.assertEqual(result, '3')

    def test_ceil_negative(self):
        result = self._render_test_template(
            template_string='{{ value|math_ceil }}',
            context={'value': -2.9}
        )

        self.assertEqual(result, '-2')

    def test_divide_float(self):
        value_1 = 2.2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_divide:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 / value_2
            )
        )

    def test_divide_integer(self):
        value_1 = 5
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_divide:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 / value_2
            )
        )

    def test_exponentiate_float(self):
        value_1 = 4.2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_exponentiate:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 ** value_2
            )
        )

    def test_exponentiate_integer(self):
        value_1 = 2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_exponentiate:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 ** value_2
            )
        )

    def test_floor(self):
        result = self._render_test_template(
            template_string='{{ value|math_floor }}',
            context={'value': 2.9}
        )

        self.assertEqual(result, '2')

    def test_floor_negative(self):
        result = self._render_test_template(
            template_string='{{ value|math_floor }}',
            context={'value': -2.1}
        )

        self.assertEqual(result, '-3')

    def test_floor_divide_float(self):
        value_1 = 20.2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_floor_divide:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 // value_2
            )
        )

    def test_floor_divide_integer(self):
        value_1 = 10
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_floor_divide:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 // value_2
            )
        )

    def test_integer_positive(self):
        result = self._render_test_template(
            template_string='{{ value|math_integer }}',
            context={'value': 2.9}
        )

        self.assertEqual(result, '2')

    def test_integer_negative_truncates_toward_zero(self):
        result = self._render_test_template(
            template_string='{{ value|math_integer }}',
            context={'value': -2.9}
        )

        self.assertEqual(result, '-2')

    def test_integer_string_input(self):
        result = self._render_test_template(
            template_string='{{ value|math_integer }}',
            context={'value': ' 7.99 '}
        )

        self.assertEqual(result, '7')

    def test_maximum(self):
        result = self._render_test_template(
            template_string='{{ value|math_maximum:argument }}',
            context={'value': 10, 'argument': 3}
        )

        self.assertEqual(result, '10')

    def test_maximum_with_string_argument(self):
        result = self._render_test_template(
            template_string='{{ value|math_maximum:argument }}',
            context={'value': 10, 'argument': '25'}
        )

        self.assertEqual(result, '25')

    def test_minimum(self):
        result = self._render_test_template(
            template_string='{{ value|math_minimum:argument }}',
            context={'value': 10, 'argument': 3}
        )

        self.assertEqual(result, '3')

    def test_minimum_with_string_argument(self):
        result = self._render_test_template(
            template_string='{{ value|math_minimum:argument }}',
            context={'value': 10, 'argument': '8'}
        )

        self.assertEqual(result, '8')

    def test_modulo_float(self):
        value_1 = 20.2
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_modulo:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 % value_2
            )
        )

    def test_modulo_integer(self):
        value_1 = 10
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_modulo:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 % value_2
            )
        )

    def test_multiply_float(self):
        value_1 = 10.5
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_multiply:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 * value_2
            )
        )

    def test_multiply_integer(self):
        value_1 = 20
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_multiply:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 * value_2
            )
        )

    def test_percent_default_digits(self):
        result = self._render_test_template(
            template_string='{% math_percent value total %}',
            context={'value': 1, 'total': 8}
        )

        self.assertEqual(result, '12.5')

    def test_percent_custom_digits(self):
        result = self._render_test_template(
            template_string='{% math_percent value total digits %}',
            context={'value': 1, 'total': 3, 'digits': 1}
        )

        self.assertEqual(result, '33.3')

    def test_percent_zero_total_returns_numeric_default(self):
        result = self._render_test_template(
            template_string='{% math_percent value total digits default %}',
            context={'value': 5, 'total': 0, 'digits': 2, 'default': 0}
        )

        self.assertEqual(result, '0')

    def test_percent_zero_total_returns_custom_numeric_default(self):
        result = self._render_test_template(
            template_string='{% math_percent value total digits default %}',
            context={'value': 5, 'total': 0, 'digits': 2, 'default': 99}
        )

        self.assertEqual(result, '99')

    def test_percent_string_inputs(self):
        result = self._render_test_template(
            template_string='{% math_percent value total digits %}',
            context={'value': '25', 'total': '200', 'digits': '1'}
        )

        self.assertEqual(result, '12.5')

    def test_round(self):
        result = self._render_test_template(
            template_string='{{ value|math_round }}',
            context={'value': 2.6}
        )
        self.assertEqual(result, '3')

    def test_round_to_digits(self):
        result = self._render_test_template(
            template_string='{{ value|math_round:digits }}',
            context={'digits': 2, 'value': 12.344}
        )
        self.assertEqual(result, '12.34')

    def test_round_argument_coerced_from_string(self):
        result = self._render_test_template(
            template_string='{{ value|math_round:digits }}',
            context={'digits': '3', 'value': 1.23456}
        )
        self.assertEqual(result, '1.235')

    def test_square_root_float(self):
        value = 10.5
        result = self._render_test_template(
            template_string='{{ value| math_square_root }}',
            context={'value': value}
        )
        self.assertEqual(
            result, str(
                math.sqrt(value)
            )
        )

    def test_square_root_integer(self):
        value = 16
        result = self._render_test_template(
            template_string='{{ value| math_square_root }}',
            context={'value': value}
        )
        self.assertEqual(
            result, str(
                math.sqrt(value)
            )
        )

    def test_subtract_float(self):
        value_1 = 50
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_subtract:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 - value_2
            )
        )

    def test_subtract_integer(self):
        value_1 = 60.5
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_subtract:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 - value_2
            )
        )

    def test_substract_float(self):
        value_1 = 50
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_substract:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 - value_2
            )
        )

    def test_substract_integer(self):
        value_1 = 60.5
        value_2 = 2
        result = self._render_test_template(
            template_string='{{ value_1 | math_substract:value_2 }}',
            context={'value_1': value_1, 'value_2': value_2}
        )
        self.assertEqual(
            result, str(
                value_1 - value_2
            )
        )
