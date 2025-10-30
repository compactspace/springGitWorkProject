package com.spring.finall.common.util;

import java.lang.reflect.Field;
import java.util.Map;

public class MapToVOConverter {

    public static <T> T convert(Map<String, Object> map, Class<T> clazz) {
        try {
            T vo = clazz.getDeclaredConstructor().newInstance();
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                try {
                    Field field = clazz.getDeclaredField(entry.getKey());
                    field.setAccessible(true);
                    Object value = entry.getValue();
                    if (value != null && !field.getType().isAssignableFrom(value.getClass())) {
                        value = convertValue(value, field.getType());
                    }
                    field.set(vo, value);
                } catch (NoSuchFieldException ignored) {}
            }
            return vo;
        } catch (Exception e) {
            throw new RuntimeException("Map → VO 변환 중 오류 발생", e);
        }
    }

    private static Object convertValue(Object value, Class<?> targetType) {
        if (value == null) return null;
        if (targetType == String.class) return value.toString();
        if (targetType == int.class || targetType == Integer.class) return Integer.parseInt(value.toString());
        if (targetType == long.class || targetType == Long.class) return Long.parseLong(value.toString());
        if (targetType == boolean.class || targetType == Boolean.class) return Boolean.parseBoolean(value.toString());
        return value;
    }
}
