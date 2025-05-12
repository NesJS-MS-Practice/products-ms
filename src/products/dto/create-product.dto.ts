import { Type } from 'class-transformer';
import { IsNumber, Min } from 'class-validator';

export class CreateProductDto {
  // @IsNumber()
  // id: number;

  @IsNumber({ maxDecimalPlaces: 4 })
  @Min(0)
  @Type(() => Number)
  price: number;
}
